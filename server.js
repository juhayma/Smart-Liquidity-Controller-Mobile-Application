const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Database connection
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false
});

// Test database connection
pool.connect()
  .then(() => console.log('✅ Connected to PostgreSQL database'))
  .catch(err => console.error('❌ Database connection error:', err));

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.static('public'));

// Routes
app.get('/', (req, res) => {
  res.json({ 
    message: 'EXIT Platform API is running!',
    version: '1.0.0',
    endpoints: [
      'GET /api/startups',
      'POST /api/submissions',
      'GET /api/founders',
      'GET /api/events'
    ]
  });
});

// API Routes

// 1. Submit startup application
app.post('/api/submissions', async (req, res) => {
  try {
    const {
      company_name,
      description,
      sector,
      country,
      stage,
      website,
      contact_email,
      founder_name,
      founder_email
    } = req.body;

    // Generate reference ID
    const referenceId = 'REF-' + Date.now() + '-' + Math.random().toString(36).substr(2, 5).toUpperCase();

    // Insert submission
    const submissionQuery = `
      INSERT INTO document_submissions 
      (reference_id, company_name, description, sector, country, stage, website, contact_email, status)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, 'pending')
      RETURNING *
    `;

    const result = await pool.query(submissionQuery, [
      referenceId,
      company_name,
      description,
      sector,
      country,
      stage,
      website,
      contact_email
    ]);

    res.status(201).json({
      success: true,
      message: 'Application submitted successfully!',
      reference_id: referenceId,
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Error submitting application:', error);
    res.status(500).json({
      success: false,
      message: 'Error submitting application',
      error: error.message
    });
  }
});

// 2. Get all submissions (Admin)
app.get('/api/submissions', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT * FROM document_submissions 
      ORDER BY created_at DESC
    `);

    res.json({
      success: true,
      count: result.rows.length,
      data: result.rows
    });

  } catch (error) {
    console.error('Error fetching submissions:', error);
    res.status(500).json({
      success: false,
      message: 'Error fetching submissions',
      error: error.message
    });
  }
});

// 3. Update submission status (Admin)
app.put('/api/submissions/:id/status', async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;

    if (!['pending', 'approved', 'rejected'].includes(status)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid status. Must be: pending, approved, or rejected'
      });
    }

    const result = await pool.query(
      'UPDATE document_submissions SET status = $1, updated_at = NOW() WHERE id = $2 RETURNING *',
      [status, id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Submission not found'
      });
    }

    res.json({
      success: true,
      message: `Submission ${status} successfully`,
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Error updating submission:', error);
    res.status(500).json({
      success: false,
      message: 'Error updating submission',
      error: error.message
    });
  }
});

// 4. Get all startups
app.get('/api/startups', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT 
        s.*,
        p.name as program_name,
        COUNT(DISTINCT sf.founder_id) as founder_count
      FROM startups s
      LEFT JOIN programs p ON s.program_id = p.id
      LEFT JOIN startup_founders sf ON s.id = sf.startup_id
      GROUP BY s.id, p.name
      ORDER BY s.created_at DESC
    `);

    res.json({
      success: true,
      count: result.rows.length,
      data: result.rows
    });

  } catch (error) {
    console.error('Error fetching startups:', error);
    res.status(500).json({
      success: false,
      message: 'Error fetching startups',
      error: error.message
    });
  }
});

// 5. Get all founders
app.get('/api/founders', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT 
        f.*,
        COUNT(DISTINCT sf.startup_id) as startup_count
      FROM founders f
      LEFT JOIN startup_founders sf ON f.id = sf.founder_id
      GROUP BY f.id
      ORDER BY f.created_at DESC
    `);

    res.json({
      success: true,
      count: result.rows.length,
      data: result.rows
    });

  } catch (error) {
    console.error('Error fetching founders:', error);
    res.status(500).json({
      success: false,
      message: 'Error fetching founders',
      error: error.message
    });
  }
});

// 6. Get platform statistics
app.get('/api/stats', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM platform_kpis_mv');
    
    res.json({
      success: true,
      data: result.rows[0] || {
        total_founders: 0,
        total_startups: 0,
        upcoming_events: 0,
        past_events: 0
      }
    });

  } catch (error) {
    console.error('Error fetching stats:', error);
    res.status(500).json({
      success: false,
      message: 'Error fetching statistics',
      error: error.message
    });
  }
});

// 7. Get all events
app.get('/api/events', async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT 
        e.*,
        p.name as program_name
      FROM events e
      LEFT JOIN programs p ON e.program_id = p.id
      ORDER BY e.start_at ASC
    `);

    res.json({
      success: true,
      count: result.rows.length,
      data: result.rows
    });

  } catch (error) {
    console.error('Error fetching events:', error);
    res.status(500).json({
      success: false,
      message: 'Error fetching events',
      error: error.message
    });
  }
});

// 8. Create new event (Admin)
app.post('/api/events', async (req, res) => {
  try {
    const {
      title,
      start_at,
      end_at,
      venue,
      is_online,
      program_id
    } = req.body;

    const result = await pool.query(`
      INSERT INTO events (title, start_at, end_at, venue, is_online, program_id)
      VALUES ($1, $2, $3, $4, $5, $6)
      RETURNING *
    `, [title, start_at, end_at, venue, is_online, program_id]);

    res.status(201).json({
      success: true,
      message: 'Event created successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Error creating event:', error);
    res.status(500).json({
      success: false,
      message: 'Error creating event',
      error: error.message
    });
  }
});

// 9. RSVP for event
app.post('/api/events/:id/rsvp', async (req, res) => {
  try {
    const { id } = req.params;
    const {
      name,
      email,
      phone,
      company,
      role
    } = req.body;

    // Check if event exists
    const eventResult = await pool.query('SELECT * FROM events WHERE id = $1', [id]);
    
    if (eventResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Event not found'
      });
    }

    // Generate reference ID
    const referenceId = 'RSV-' + Date.now() + '-' + Math.random().toString(36).substr(2, 5).toUpperCase();

    // For now, we'll just return success (in real app, save to RSVP table)
    res.status(201).json({
      success: true,
      message: 'RSVP submitted successfully',
      data: {
        reference_id: referenceId,
        event_id: id,
        name,
        email
      }
    });

  } catch (error) {
    console.error('Error submitting RSVP:', error);
    res.status(500).json({
      success: false,
      message: 'Error submitting RSVP',
      error: error.message
    });
  }
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    success: false,
    message: 'Something went wrong!',
    error: process.env.NODE_ENV === 'development' ? err.message : 'Internal server error'
  });
});

// 404 handler
app.use((req, res) => {
  res.status(404).json({
    success: false,
    message: 'Route not found'
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`🚀 EXIT Platform server running on http://localhost:${PORT}`);
  console.log(`📊 API Documentation: http://localhost:${PORT}`);
});
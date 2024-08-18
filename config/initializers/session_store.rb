Rails.application.config.session_store :redis_store, 
  servers: {
    host: 'redis',
    port: 6379,
    db: 0,
    namespace: 'session'
  }, 
  key: '_wallet_trans_session',
  expire_after: 90.minutes

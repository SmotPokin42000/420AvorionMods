function WormholeGuardian.onDestroyed()
    Server():setValue("guardian_respawn_time", 20 * 60)
end
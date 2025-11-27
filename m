Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3906F334373
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Nov 2025 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257820; cv=none; b=r/2IDArYe1OVEk6hJoC5/Wh1BjXfxpxk+o4Vmwm7AnftwIkR7hNR3VADmV9kyw9NlxzKn56WkD4JfxK17hYudg8jpRxKF5O0LjeQ/Dp5J2P37T6eskCebpJQmD+UvS5+z2mDt4E2bcL+pvP0FhtXJSR7fj3rPsbCBx0CeZw+jXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257820; c=relaxed/simple;
	bh=k4gPNHoL4MJF+D0pf4JACPMYpPJ2jai4d1AFUsBo7V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5zSjeeYyR7SobJV/FXeoCtWR9eGBS/vfAk3EqfLrQR9aPXqPF57jSJGADAUmhkOTWAvp+nDDUb+/kr+8PKlLWqCoqQs/knN49rpVs80D8xKa2rGlbRd12tKSe+4eKhkZU4KyAi0E9e13ZQvxfLoIRSYQYxfptTMBxh83Uj5FZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v9qJ3bv8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J5oSbjTT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v9qJ3bv8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J5oSbjTT"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764257817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/Nn68Ddw/Fncp1s8CRDPoTrMJ8Q88l3KYYI44OQK2I=;
	b=v9qJ3bv8dP7RoiONDLHzQm9crOq8Wny2kH1szX7bM7C4te1IBbewWqKxKRWgbHoy6hKHCb
	5vgj1tYqnk/zRhHR9IMw/lJmY55l/SZMQkxKpoV+TEypue0bRLZ8VLZfF2IHTRBNhhZAVx
	m8f+vl02LKl5+yYTNSSvnt8JZS3i4tJFeCKE3pDUv8sr54vl3M+v4+kWrcMmNgiHty9PH/
	F2hYapiuvHOGam/zeJ+oio60VkI+mvspS+j6WVMl7vo1mn52FlFLpU+A1TqlPM84jz32Ok
	Rwnl0F5AOG3vGlo2ELudmbl9tOPIwi3J/6+VtXmYnkJYVyWBJxLussh68gmZfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764257817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u/Nn68Ddw/Fncp1s8CRDPoTrMJ8Q88l3KYYI44OQK2I=;
	b=J5oSbjTT9bLxOvNleXaV7g3a0zx4UtgWhxbp9j9sc5ONvPG5T+6vFFA3L9QUeYWQVAh6si
	pw9M03Tv7xpTztCQ==
To: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] debugobjects: Use LD_WAIT_CONFIG instead of LD_WAIT_SLEEP
Date: Thu, 27 Nov 2025 16:36:52 +0100
Message-ID: <20251127153652.291697-3-bigeasy@linutronix.de>
In-Reply-To: <20251127153652.291697-1-bigeasy@linutronix.de>
References: <20251127153652.291697-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

fill_pool_map is used to suppress nesting violations caused by acquiring
a spinlock_t (from within the memory allocator) while holding a
raw_spinlock_t. The used annotation is wrong.

LD_WAIT_SLEEP is for always sleeping lock types such as mutex_t.
LD_WAIT_CONFIG is for lock type which are sleeping while spinning on
PREEMPT_RT such as spinlock_t.

Use LD_WAIT_CONFIG as override.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/debugobjects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 7017e5c8f32dd..ecf8e7f978e30 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -717,10 +717,10 @@ static void debug_objects_fill_pool(void)
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() || system_state < SYS=
TEM_SCHEDULING) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
-		 * by temporarily raising the wait-type to WAIT_SLEEP, matching
+		 * by temporarily raising the wait-type to LD_WAIT_CONFIG, matching
 		 * the preemptible() condition above.
 		 */
-		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_SLEEP);
+		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_CONFIG);
 		lock_map_acquire_try(&fill_pool_map);
 		fill_pool();
 		lock_map_release(&fill_pool_map);
--=20
2.51.0


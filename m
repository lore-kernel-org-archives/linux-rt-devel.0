Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E73314B6B
	for <linux-rt-devel@lists.linux.dev>; Tue,  4 Nov 2025 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245414; cv=none; b=ErqoQ0RuslL8wtwMoXJTKj3LJw6VvpbvvMwUk66Wl7H7rYhDw5ZJ+tsfErOTIQGTSyw/NiRs91y5bVhD3sAD97izu/t3OtBkqMfR1JFcUl3rCjCZhK547gBRt+rv9OeM60mlFpoZILi4EuKU3R+opZDlpHvrEw2TIPcygYCZR7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245414; c=relaxed/simple;
	bh=Fd7xqMKtI1czeZVZmJUm2zI3Khx3lzpsyMWufRJ+Cw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IECs66yVC5tf+9qC41JIFqq0Uod1AWtfvZJKURxGRt3eBaWu9meDbYndBtMY2tD/B2MvhSJE+xIXWHr1U3uf25CK2eZjGpLezI0CwFBX6l0y7Hy4D2z3sEvam2dzgNt4d7vtocDZa8VjpmF3T1/lPOwUsGrMQssnRuKVf5foUmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=As93AkEN; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="As93AkEN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1762245409;
	bh=Fd7xqMKtI1czeZVZmJUm2zI3Khx3lzpsyMWufRJ+Cw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=As93AkENGMkbwPoa0FSt5rwfNKyLYT7u89ildkhoN38RkFkgrONr+85xGiXk9TeV5
	 7XkXMLRfpkiTixfke/eGkDqpF6g1SjxI+Y/0pEMdHvSbkrad2ltmJi48S6Rp1PzFfS
	 0YzKovgRersgq5aO71TAcXssivkaRAj7VUZyG+ztohv8bv3JFkm5JqQlcr/B6o3CyU
	 g67Cv3w0vOnMtBc/uG/ZVjvYwfGxMSLxhu9liC6IhIx1/WFFzhgJxd4wtpq6Xje/ax
	 fk1mGFiNCU08enwVjiO236gPxxtWc3fxIEp7Z85cf4AdkWA3q6JBR6dmCQn7OeGdXu
	 JqKXKx2EwYU6Q==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	Maarten Lankhorst <dev@lankhorst.se>,
	Mario Kleiner <mario.kleiner.de@gmail.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 6/7] drm/i915/display: Enable interrupts earlier on PREEMPT_RT
Date: Tue,  4 Nov 2025 09:36:30 +0100
Message-ID: <20251104083634.670753-7-dev@lankhorst.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104083634.670753-1-dev@lankhorst.se>
References: <20251104083634.670753-1-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last part of the vblank evasion is about updating bookkeeping,
not programming hardware registers.

The interrupts cannot stay disabled here on PREEMPT_RT since the
spinlocks get converted to mutexes.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/display/intel_crtc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_crtc.c b/drivers/gpu/drm/i915/display/intel_crtc.c
index 9d2a23c96c61b..b87f6b4a4f3d7 100644
--- a/drivers/gpu/drm/i915/display/intel_crtc.c
+++ b/drivers/gpu/drm/i915/display/intel_crtc.c
@@ -688,6 +688,14 @@ void intel_pipe_update_end(struct intel_atomic_state *state,
 	    intel_crtc_has_type(new_crtc_state, INTEL_OUTPUT_DSI))
 		icl_dsi_frame_update(new_crtc_state);
 
+#if IS_ENABLED(CONFIG_PREEMPT_RT)
+	/*
+	 * Timing sensitive register writing completed, non-deterministic
+	 * locking from here on out.
+	 */
+	local_irq_enable();
+#endif
+
 	/* We're still in the vblank-evade critical section, this can't race.
 	 * Would be slightly nice to just grab the vblank count and arm the
 	 * event outside of the critical section - the spinlock might spin for a
@@ -735,7 +743,9 @@ void intel_pipe_update_end(struct intel_atomic_state *state,
 	if (!state->base.legacy_cursor_update)
 		intel_vrr_send_push(NULL, new_crtc_state);
 
+#if !IS_ENABLED(CONFIG_PREEMPT_RT)
 	local_irq_enable();
+#endif
 
 	if (intel_vgpu_active(dev_priv))
 		goto out;
-- 
2.51.0


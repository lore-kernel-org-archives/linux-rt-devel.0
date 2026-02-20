Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D15327B352
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576653; cv=none; b=mFhtFleAq7XPYoSNYuGtfvi8i8+vODz3I7TqwQD43sKtHmXwgIduk0bqfk9SiGnNFdPPNd2sTsuztrZOLO/RUrorTD9tON7SqjenxoXK65TomJtP17fdjsrtd6644J7LCzOElliT7XakZ5Tc28xQgHxxZ0H+1gEYh0M3tzMeWWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576653; c=relaxed/simple;
	bh=RrcmqO9eSOyz9QRfifZirD+s/l2zftXQ4PdoDD5fa6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+up73a9uQHTgQeX21111z3ddqq6JmB2uH6dFQTDTHaPeJvBkeJ8coRDMp2o9VWTZ6oR6VTXY1aCfBbINfYRGCaEkwQ7nnbQvDyg1UfbtIOm3qwMCuGbFBR6c6sX8tVpbqeltNgRfRgZkRqJlcS4CsBrre794JNzdnvNRq+cZdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=C7US5fKp; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="C7US5fKp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1771576650;
	bh=RrcmqO9eSOyz9QRfifZirD+s/l2zftXQ4PdoDD5fa6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7US5fKpP36KDRnDX6jf433tLZ4FjFUvlmr6LKKreFK73C7RvYfzxm45W5SB52bb1
	 szpdXMmpxLEn9856LMhBKt9cbY1zXFP6tw5OoYBXEsXgbkdJ+AHhczKJJ0t5brWxZ5
	 SBy2yLWLQVAMH7uACyMa0W8eJbnE11xUEQEnBRadxn1cbBejZEiF9vxegeVj8sD/yn
	 GsiSQLelt+M6iz95vsi1/a6TPLXLIMyDrRwSOenH01CHYbWWdtcuNnNGCzY35mG0oo
	 +a98BQiqbs80JdpB6f6nixFwULo3gCAbRh37/Y3svAtWZeh1y9e4QK4gCXqueZEvfc
	 Kujcu+R6GoewQ==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [i915-rt v6 14/24] drm/i915/display: Make set_pipeconf use the fw variants
Date: Fri, 20 Feb 2026 09:37:12 +0100
Message-ID: <20260220083657.28815-40-dev@lankhorst.se>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220083657.28815-26-dev@lankhorst.se>
References: <20260220083657.28815-26-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The calls are used inside the critical section when updating
the gamma mode, and thus should use the _fw variants to prevent
locks.

Fixes following splat:
| BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
| in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 2115, name: modprobe
| preempt_count: 0, expected: 0
| RCU nest depth: 0, expected: 0
| 4 locks held by modprobe/2115:
|  #0: ffff99b9425161a0 (&dev->mutex){....}-{4:4}, at: __driver_attach+0xaf/0x1c0
|  #1: ffffaa224810f6c0 (crtc_ww_class_acquire){+.+.}-{0:0}, at: intel_initial_commit+0x4c/0x200 [i915]
|  #2: ffffaa224810f6e8 (crtc_ww_class_mutex){+.+.}-{4:4}, at: intel_initial_commit+0x4c/0x200 [i915]
|  #3: ffff99b94a6c9030 (&uncore->lock){+.+.}-{3:3}, at: gen6_write32+0x50/0x290 [i915]
| irq event stamp: 513344
| hardirqs last  enabled at (513343): [<ffffffff8ba8d84c>] _raw_spin_unlock_irqrestore+0x4c/0x60
| hardirqs last disabled at (513344): [<ffffffffc1543646>] intel_pipe_update_start+0x216/0x2c0 [i915]
| softirqs last  enabled at (512766): [<ffffffff8af045cf>] __local_bh_enable_ip+0x10f/0x170
| softirqs last disabled at (512712): [<ffffffffc14dfb6a>] __i915_request_queue+0x3a/0x70 [i915]
| CPU: 3 UID: 0 PID: 2115 Comm: modprobe Tainted: G        W           6.18.0-rc1+ #17 PREEMPT_{RT,(lazy)}
| Tainted: [W]=WARN
| Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./Z68 Pro3-M, BIOS P2.30 06/29/2012
| Call Trace:
|  <TASK>
|  dump_stack_lvl+0x68/0x90
|  __might_resched.cold+0xf0/0x12b
|  rt_spin_lock+0x5f/0x200
|  gen6_write32+0x50/0x290 [i915]
|  ilk_set_pipeconf+0x12d/0x230 [i915]
|  ilk_color_commit_arm+0x2d/0x70 [i915]
|  intel_update_crtc+0x15b/0x690 [i915]
|  intel_commit_modeset_enables+0xa6/0xd0 [i915]
|  intel_atomic_commit_tail+0xd55/0x19a0 [i915]
|  intel_atomic_commit+0x25d/0x2a0 [i915]
|  drm_atomic_commit+0xad/0xe0 [drm]
|  intel_initial_commit+0x16c/0x200 [i915]
|  intel_display_driver_probe+0x2e/0x80 [i915]
|  i915_driver_probe+0x791/0xc10 [i915]
|  i915_pci_probe+0xd7/0x190 [i915]

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/display/intel_display.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 8fba2a8b6a6b5..2129fad13b17c 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -3037,8 +3037,9 @@ void i9xx_set_pipeconf(const struct intel_crtc_state *crtc_state)
 
 	val |= TRANSCONF_FRAME_START_DELAY(crtc_state->framestart_delay - 1);
 
-	intel_de_write(display, TRANSCONF(display, cpu_transcoder), val);
-	intel_de_posting_read(display, TRANSCONF(display, cpu_transcoder));
+	intel_de_write_fw(display, TRANSCONF(display, cpu_transcoder), val);
+	/* posting read */
+	intel_de_read_fw(display, TRANSCONF(display, cpu_transcoder));
 }
 
 static enum intel_output_format
@@ -3233,8 +3234,9 @@ void ilk_set_pipeconf(const struct intel_crtc_state *crtc_state)
 	val |= TRANSCONF_FRAME_START_DELAY(crtc_state->framestart_delay - 1);
 	val |= TRANSCONF_MSA_TIMING_DELAY(crtc_state->msa_timing_delay);
 
-	intel_de_write(display, TRANSCONF(display, cpu_transcoder), val);
-	intel_de_posting_read(display, TRANSCONF(display, cpu_transcoder));
+	intel_de_write_fw(display, TRANSCONF(display, cpu_transcoder), val);
+	/* posting read */
+	intel_de_read_fw(display, TRANSCONF(display, cpu_transcoder));
 }
 
 static void hsw_set_transconf(const struct intel_crtc_state *crtc_state)
-- 
2.51.0


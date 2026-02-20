Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33772C1788
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Feb 2026 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576986; cv=none; b=RSaTGMx+e6/o2q6r0blnbkmanBx77tqfvb5YImvv8L7CVqCm8GSNzehrbQQfPYDwfnawtoN1bxtj7L0eDt7/1enBh4th8weYCKO9bFfT7IgVRZcyNrs+frOfPT9IKYy19uENFPHw2oTNgHLoDtR11vfbRDGgDiV0euqgij0C8sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576986; c=relaxed/simple;
	bh=ribdt2XKZLFzHEjet/mJhvsCBSi9vQGY9MjGkJmA/HM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KbyKIyT2/4incjx1/Wzwi5bkvg/69op75jTv24BDq6VTPXCIF3y5EXPleDtTI//33tSY59t+/PRdmYiqibI+SSvDAlztDqkWxeucy3DtHL8L2sh4tUeHD2MJURdco/KsMYlqbzx1O0HVsu/Acp+PuFvrKZB0FN5/RNxw+j4neq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=h2SWT7nM; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="h2SWT7nM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1771576627;
	bh=ribdt2XKZLFzHEjet/mJhvsCBSi9vQGY9MjGkJmA/HM=;
	h=From:To:Cc:Subject:Date:From;
	b=h2SWT7nM4N0zAYlOZ/RkzO6qEIRDBg8bBgzGbjuW2JbOyU62tT/q2u6HEWQO/kmwf
	 cXX0KsWP2BDypx6B6+eMhaMBb/Fbt2FIEmN9jO6d8tdv1elSIB9QmQPKt1f4iPPceO
	 gQ6Qeka7raP5+TVuDCkfoR/HA4Sy6u7L6UQnMreWEe4nkrXV1sGAf/zK43qwHYNsUv
	 iT5osqkMbqXq3XtEXh8h2k3n+HU8gXUjvbtzNSRJPY4yR+UKtDtZGrHzcZ2vo9cake
	 m2Uq58xDRbn3qtxLEKvG4RRTTqCF8nRu39Dx1Ll/bn/Qgy1fK7jdc0qkqhjDQKFAjR
	 0Glsc74GdREfA==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [i915-rt v6 00/24] drm/i915/display: All patches to make PREEMPT_RT work on i915 + xe.
Date: Fri, 20 Feb 2026 09:36:58 +0100
Message-ID: <20260220083657.28815-26-dev@lankhorst.se>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

New version, new approach!

A lot of the problems with PREEMPT_RT happen because of the current vblank
handling. The real solution is making it more deterministic.

After calling local_irq_disable(), all kinds of register reads/writes are
done until interrupts are enabled again, without any lock used at all.

Patch 1-10 fixes all code related to vblank handling.
Patch 11-14 fixes all accidental locking in the atomic commit path.
Patch 15 is a standalone fix for interrupts, will probably push if xe results are clean.
Patch 16-20 fix problems in i915 specific driver code.
Patch 21, 23 and 24 are broken, but silences i915 in CI, should not be upstreamed.
Finally, patch 22 enables PREEMPT_RT on i915 too.

There are still failures on CI because of the uncore lock being problematic.

Still, I hope this series makes both the PREEMPT_RT devs and intel/display
folk equally (un)happy with this sequence:

local_irq_disable()
bunch of timing sensitive register writes without a single lock
local_irq_enable()

Maarten Lankhorst (19):
  drm/vblank_work: Add methods to schedule vblank_work in 2 stages
  drm/vblank: Add a 2-stage version of drm_crtc_arm_vblank_event
  drm/intel/display: Make intel_crtc_arm_vblank_event static
  drm/intel/display: Convert vblank event handling to 2-stage arming
  drm/i915/display: Move vblank put until after critical section
  drm/i915/display: Remove locking from intel_vblank_evade critical
    section
  drm/i915/display: Handle vlv dsi workaround in scanline_in_safe_range
    too
  drm/i915/display: Make get_vblank_counter use intel_de_read_fw()
  drm/i915/display: Do not take uncore lock in i915_get_vblank_counter
  drm/i915/display: Make icl_dsi_frame_update use _fw too
  drm/i915/display: Use intel_de_read/write_fw in colorops
  drm/i915/display: Use intel_de_write_fw in intel_pipe_fastset
  drm/i915/display: Make set_pipeconf use the fw variants
  drm/i915/display: Fix intel_lpe_audio_irq_handler for PREEMPT-RT
  drm/i915/gt: Fix selftests on PREEMPT_RT
  drm/i915/gt: Set stop_timeout() correctly on PREEMPT-RT
  drm/i915/display: Remove uncore lock from vlv_atomic_update_fifo
  PREEMPT_RT injection
  FOR-CI: bump MAX_STACK_TRACE_ENTRIES

Mike Galbraith (1):
  drm/i915: Use preempt_disable/enable_rt() where recommended

Sebastian Andrzej Siewior (4):
  drm/i915/gt: Use spin_lock_irq() instead of local_irq_disable() +
    spin_lock()
  drm/i915: Drop the irqs_disabled() check
  drm/i915/guc: Consider also RCU depth in busy loop.
  Revert "drm/i915: Depend on !PREEMPT_RT."

 drivers/gpu/drm/drm_vblank.c                  |  61 +++++++++-
 drivers/gpu/drm/drm_vblank_work.c             | 106 ++++++++++++----
 drivers/gpu/drm/i915/Kconfig                  |   1 -
 drivers/gpu/drm/i915/Kconfig.debug            |  15 ---
 drivers/gpu/drm/i915/display/i9xx_wm.c        |   4 -
 drivers/gpu/drm/i915/display/icl_dsi.c        |   4 +-
 drivers/gpu/drm/i915/display/intel_color.c    |   6 +-
 drivers/gpu/drm/i915/display/intel_crtc.c     |  86 ++++++-------
 drivers/gpu/drm/i915/display/intel_crtc.h     |   1 -
 drivers/gpu/drm/i915/display/intel_cursor.c   |   8 +-
 drivers/gpu/drm/i915/display/intel_de.h       |   8 ++
 drivers/gpu/drm/i915/display/intel_display.c  |  46 +++----
 .../gpu/drm/i915/display/intel_lpe_audio.c    |   2 +-
 drivers/gpu/drm/i915/display/intel_vblank.c   | 115 ++++++++++--------
 drivers/gpu/drm/i915/display/intel_vblank.h   |   1 +
 drivers/gpu/drm/i915/display/intel_vrr.c      |  18 +--
 drivers/gpu/drm/i915/gt/intel_engine_cs.c     |   2 +-
 .../drm/i915/gt/intel_execlists_submission.c  |  17 +--
 drivers/gpu/drm/i915/gt/selftest_engine_pm.c  |   8 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.h        |   2 +-
 drivers/gpu/drm/i915/i915_request.c           |   2 -
 drivers/gpu/drm/i915/intel_uncore.h           |  26 ++--
 drivers/gpu/drm/xe/Kconfig.debug              |   5 +
 .../drm/xe/compat-i915-headers/intel_uncore.h |   7 ++
 include/drm/drm_vblank.h                      |  14 ++-
 include/drm/drm_vblank_work.h                 |  12 ++
 kernel/Kconfig.preempt                        |   4 +-
 lib/Kconfig.debug                             |   4 +-
 28 files changed, 376 insertions(+), 209 deletions(-)

-- 
2.51.0


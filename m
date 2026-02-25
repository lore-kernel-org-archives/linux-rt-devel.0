Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D6538E13D
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Feb 2026 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011513; cv=none; b=mWq+naFRMrmZp28RLQkBEZMhuZ/ofVzcAXKDnvW+pv1Gvs05rlDOQf0f3wLSbYBMsi4WWWInNjnXmBBHhvZlKWtUOKTEcAq27cFX1IK5+AMN4HbL53Z6DStjNSYdRjFQPHkpj827koevrDewsOY/gAoxjiR4eMXObukxLHpau+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011513; c=relaxed/simple;
	bh=rMgjVD4GMsRX9ziLSps8kmQoitGnqhBrUnNKkSzdO5Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FbBrzWnemapPuXwFj20mE4p/9RmR0ePPVXKA9QWaYGgjXs5Vw5vI4URdxyE8W4CeO4Gqvu9GRWqmOniFa77dJYVCG9YQiuntZnBDEKWRLvJo0tXCA8rDRDxELrVKa9VYZo4iUnL6yPi5Lqd0+Pxgd4fTEJKKsqUvYCPAETUQ4vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fpS3cDXX; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fpS3cDXX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772011512; x=1803547512;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=rMgjVD4GMsRX9ziLSps8kmQoitGnqhBrUnNKkSzdO5Y=;
  b=fpS3cDXXFD+O6hHI9BtfDtnurO+yLy9ziEDA0jiK3o1TPejyBcRVTrBq
   H5QCox8nSiAy2ybbUiAe5X5hzNT4qnOtCr2OtdzYe5rKsay/r7yDOZ7HE
   G0VDx8+Nm7CBJFLj4KsNocc72CuG7peaBKSZTUPFEn8up4/oyQ1b0zDSh
   S7zktUUqvjmMyvOqNesOMxaergzof/zGuBMmse3r/RUsKNPhYPcRuP832
   +5g2a999WQbZG4tVPluZ9inVEUBaiPvWqt2Fvd6jpu3RcF5Y7qn3HyR9D
   JFEEFIskCGUaBxWV35U2dignCrKkF7ivPzR4B3kJe1aU0hkhGJpKV3DuR
   w==;
X-CSE-ConnectionGUID: JalTlMNRQBadyt1Ags27vg==
X-CSE-MsgGUID: Wd4/4Ih5QHOX8iS0SqHXdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="73115291"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="73115291"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 01:25:11 -0800
X-CSE-ConnectionGUID: N3KGhzIGS3afP7PTcMA/dg==
X-CSE-MsgGUID: 3UKWWixzQl6pWcpgZ6o6VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="221178397"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.68])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 01:25:08 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Maarten Lankhorst <dev@lankhorst.se>, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: linux-rt-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, Maarten
 Lankhorst <dev@lankhorst.se>
Subject: Re: [i915-rt v6 13/24] drm/i915/display: Use intel_de_write_fw in
 intel_pipe_fastset
In-Reply-To: <20260220083657.28815-39-dev@lankhorst.se>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260220083657.28815-26-dev@lankhorst.se>
 <20260220083657.28815-39-dev@lankhorst.se>
Date: Wed, 25 Feb 2026 11:25:05 +0200
Message-ID: <4537cb8e981e2f49e1ba212237134dc5e812756e@intel.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, 20 Feb 2026, Maarten Lankhorst <dev@lankhorst.se> wrote:
> intel_set_pipe_src_size(), hsw_set_linetime_wm(),
> intel_cpu_transcoder_set_m1_n1() and intel_set_transcoder_timings_lrr()
> are called from an atomic context on PREEMPT_RT, and should be using the
> _fw functions.

Problem is, ~nobody knows when they should be using _fw anymore when
they're all over the place. It'll get cargo culted.

BR,
Jani.


>
> This likely prevents a deadlock on i915.
>
> Again noticed when trying to disable preemption in vblank evasion:
> <3> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> <3> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1505, name: kms_cursor_lega
> <3> preempt_count: 1, expected: 0
> <3> RCU nest depth: 0, expected: 0
> <4> 4 locks held by kms_cursor_lega/1505:
> <4>  #0: ffffc90003c6f988 (crtc_ww_class_acquire){+.+.}-{0:0}, at: drm_mode_atomic_ioctl+0x13b/0xe90
> <4>  #1: ffffc90003c6f9b0 (crtc_ww_class_mutex){+.+.}-{3:3}, at: drm_mode_atomic_ioctl+0x13b/0xe90
> <4>  #2: ffff888135b838b8 (&intel_dp->psr.lock){+.+.}-{3:3}, at: intel_psr_lock+0xc5/0xf0 [xe]
> <4>  #3: ffff88812607bbc0 (&wl->lock){+.+.}-{2:2}, at: intel_dmc_wl_get+0x3c/0x140 [xe]
> <4> CPU: 6 UID: 0 PID: 1505 Comm: kms_cursor_lega Tainted: G     U              6.18.0-rc3-lgci-xe-xe-pw-156729v1+ #1 PREEMPT_{RT,(lazy)}
> <4> Tainted: [U]=USER
> <4> Hardware name: Intel Corporation Panther Lake Client Platform/PTL-UH LP5 T3 RVP1, BIOS PTLPFWI1.R00.3383.D02.2509240621 09/24/2025
> <4> Call Trace:
> <4>  <TASK>
> <4>  dump_stack_lvl+0xc1/0xf0
> <4>  dump_stack+0x10/0x20
> <4>  __might_resched+0x174/0x260
> <4>  rt_spin_lock+0x63/0x200
> <4>  ? intel_dmc_wl_get+0x3c/0x140 [xe]
> <4>  intel_dmc_wl_get+0x3c/0x140 [xe]
> <4>  intel_set_pipe_src_size+0x89/0xe0 [xe]
> <4>  intel_update_crtc+0x3c1/0x950 [xe]
> <4>  ? intel_pre_update_crtc+0x258/0x400 [xe]
> <4>  skl_commit_modeset_enables+0x217/0x720 [xe]
> <4>  intel_atomic_commit_tail+0xd4e/0x1af0 [xe]
> <4>  ? lock_release+0xce/0x2a0
> <4>  intel_atomic_commit+0x2e5/0x330 [xe]
> <4>  ? intel_atomic_commit+0x2e5/0x330 [xe]
> <4>  drm_atomic_commit+0xaf/0xf0
> <4>  ? __pfx___drm_printfn_info+0x10/0x10
> <4>  drm_mode_atomic_ioctl+0xbd5/0xe90
> <4>  ? lock_acquire+0xc4/0x2e0
> <4>  ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
> <4>  drm_ioctl_kernel+0xb6/0x120
> <4>  drm_ioctl+0x2d7/0x5a0
> <4>  ? __pfx_drm_mode_atomic_ioctl+0x10/0x10
> <4>  ? rt_spin_unlock+0xa0/0x140
> <4>  ? __pm_runtime_resume+0x53/0x90
> <4>  xe_drm_ioctl+0x56/0x90 [xe]
> <4>  __x64_sys_ioctl+0xa8/0x110
> <4>  ? lock_acquire+0xc4/0x2e0
> <4>  x64_sys_call+0x1144/0x26a0
> <4>  do_syscall_64+0x93/0xae0
> <4>  ? lock_release+0xce/0x2a0
> <4>  ? __task_pid_nr_ns+0xd9/0x270
> <4>  ? do_syscall_64+0x1b7/0xae0
> <4>  ? find_held_lock+0x31/0x90
> <4>  ? __task_pid_nr_ns+0xcf/0x270
> <4>  ? __lock_acquire+0x43e/0x2860
> <4>  ? __task_pid_nr_ns+0xd9/0x270
> <4>  ? lock_acquire+0xc4/0x2e0
> <4>  ? find_held_lock+0x31/0x90
> <4>  ? __task_pid_nr_ns+0xcf/0x270
> <4>  ? lock_release+0xce/0x2a0
> <4>  ? __task_pid_nr_ns+0xd9/0x270
> <4>  ? do_syscall_64+0x1b7/0xae0
> <4>  ? do_syscall_64+0x1b7/0xae0
> <4>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> ---
>  drivers/gpu/drm/i915/display/intel_display.c | 36 ++++++++++----------
>  drivers/gpu/drm/i915/display/intel_vrr.c     | 18 +++++-----
>  2 files changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index f224c9d7e0dfa..8fba2a8b6a6b5 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -1607,9 +1607,9 @@ static void hsw_set_linetime_wm(const struct intel_crtc_state *crtc_state)
>  	struct intel_display *display = to_intel_display(crtc_state);
>  	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
>  
> -	intel_de_write(display, WM_LINETIME(crtc->pipe),
> -		       HSW_LINETIME(crtc_state->linetime) |
> -		       HSW_IPS_LINETIME(crtc_state->ips_linetime));
> +	intel_de_write_fw(display, WM_LINETIME(crtc->pipe),
> +			  HSW_LINETIME(crtc_state->linetime) |
> +			  HSW_IPS_LINETIME(crtc_state->ips_linetime));
>  }
>  
>  static void hsw_set_frame_start_delay(const struct intel_crtc_state *crtc_state)
> @@ -2606,14 +2606,14 @@ void intel_set_m_n(struct intel_display *display,
>  		   i915_reg_t data_m_reg, i915_reg_t data_n_reg,
>  		   i915_reg_t link_m_reg, i915_reg_t link_n_reg)
>  {
> -	intel_de_write(display, data_m_reg, TU_SIZE(m_n->tu) | m_n->data_m);
> -	intel_de_write(display, data_n_reg, m_n->data_n);
> -	intel_de_write(display, link_m_reg, m_n->link_m);
> +	intel_de_write_fw(display, data_m_reg, TU_SIZE(m_n->tu) | m_n->data_m);
> +	intel_de_write_fw(display, data_n_reg, m_n->data_n);
> +	intel_de_write_fw(display, link_m_reg, m_n->link_m);
>  	/*
>  	 * On BDW+ writing LINK_N arms the double buffered update
>  	 * of all the M/N registers, so it must be written last.
>  	 */
> -	intel_de_write(display, link_n_reg, m_n->link_n);
> +	intel_de_write_fw(display, link_n_reg, m_n->link_n);
>  }
>  
>  bool intel_cpu_transcoder_has_m2_n2(struct intel_display *display,
> @@ -2800,9 +2800,9 @@ static void intel_set_transcoder_timings_lrr(const struct intel_crtc_state *crtc
>  	}
>  
>  	if (DISPLAY_VER(display) >= 13) {
> -		intel_de_write(display,
> -			       TRANS_SET_CONTEXT_LATENCY(display, cpu_transcoder),
> -			       crtc_state->set_context_latency);
> +		intel_de_write_fw(display,
> +				  TRANS_SET_CONTEXT_LATENCY(display, cpu_transcoder),
> +				  crtc_state->set_context_latency);
>  
>  		/*
>  		 * VBLANK_START not used by hw, just clear it
> @@ -2818,9 +2818,9 @@ static void intel_set_transcoder_timings_lrr(const struct intel_crtc_state *crtc
>  	 * The hardware actually ignores TRANS_VBLANK.VBLANK_END in DP mode.
>  	 * But let's write it anyway to keep the state checker happy.
>  	 */
> -	intel_de_write(display, TRANS_VBLANK(display, cpu_transcoder),
> -		       VBLANK_START(crtc_vblank_start - 1) |
> -		       VBLANK_END(crtc_vblank_end - 1));
> +	intel_de_write_fw(display, TRANS_VBLANK(display, cpu_transcoder),
> +			  VBLANK_START(crtc_vblank_start - 1) |
> +			  VBLANK_END(crtc_vblank_end - 1));
>  	/*
>  	 * For platforms that always use VRR Timing Generator, the VTOTAL.Vtotal
>  	 * bits are not required. Since the support for these bits is going to
> @@ -2834,9 +2834,9 @@ static void intel_set_transcoder_timings_lrr(const struct intel_crtc_state *crtc
>  	 * The double buffer latch point for TRANS_VTOTAL
>  	 * is the transcoder's undelayed vblank.
>  	 */
> -	intel_de_write(display, TRANS_VTOTAL(display, cpu_transcoder),
> -		       VACTIVE(crtc_vdisplay - 1) |
> -		       VTOTAL(crtc_vtotal - 1));
> +	intel_de_write_fw(display, TRANS_VTOTAL(display, cpu_transcoder),
> +			  VACTIVE(crtc_vdisplay - 1) |
> +			  VTOTAL(crtc_vtotal - 1));
>  
>  	intel_vrr_set_fixed_rr_timings(crtc_state);
>  	intel_vrr_transcoder_enable(crtc_state);
> @@ -2853,8 +2853,8 @@ static void intel_set_pipe_src_size(const struct intel_crtc_state *crtc_state)
>  	/* pipesrc controls the size that is scaled from, which should
>  	 * always be the user's requested size.
>  	 */
> -	intel_de_write(display, PIPESRC(display, pipe),
> -		       PIPESRC_WIDTH(width - 1) | PIPESRC_HEIGHT(height - 1));
> +	intel_de_write_fw(display, PIPESRC(display, pipe),
> +			  PIPESRC_WIDTH(width - 1) | PIPESRC_HEIGHT(height - 1));
>  }
>  
>  static bool intel_pipe_is_interlaced(const struct intel_crtc_state *crtc_state)
> diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
> index 00ca76dbdd6ce..128e19afc6c86 100644
> --- a/drivers/gpu/drm/i915/display/intel_vrr.c
> +++ b/drivers/gpu/drm/i915/display/intel_vrr.c
> @@ -318,12 +318,12 @@ void intel_vrr_set_fixed_rr_timings(const struct intel_crtc_state *crtc_state)
>  	if (!intel_vrr_possible(crtc_state))
>  		return;
>  
> -	intel_de_write(display, TRANS_VRR_VMIN(display, cpu_transcoder),
> -		       intel_vrr_fixed_rr_hw_vmin(crtc_state) - 1);
> -	intel_de_write(display, TRANS_VRR_VMAX(display, cpu_transcoder),
> -		       intel_vrr_fixed_rr_hw_vmax(crtc_state) - 1);
> -	intel_de_write(display, TRANS_VRR_FLIPLINE(display, cpu_transcoder),
> -		       intel_vrr_fixed_rr_hw_flipline(crtc_state) - 1);
> +	intel_de_write_fw(display, TRANS_VRR_VMIN(display, cpu_transcoder),
> +			  intel_vrr_fixed_rr_hw_vmin(crtc_state) - 1);
> +	intel_de_write_fw(display, TRANS_VRR_VMAX(display, cpu_transcoder),
> +			  intel_vrr_fixed_rr_hw_vmax(crtc_state) - 1);
> +	intel_de_write_fw(display, TRANS_VRR_FLIPLINE(display, cpu_transcoder),
> +			  intel_vrr_fixed_rr_hw_flipline(crtc_state) - 1);
>  }
>  
>  static
> @@ -896,8 +896,8 @@ static void intel_vrr_tg_enable(const struct intel_crtc_state *crtc_state,
>  	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
>  	u32 vrr_ctl;
>  
> -	intel_de_write(display, TRANS_PUSH(display, cpu_transcoder),
> -		       trans_vrr_push(crtc_state, false));
> +	intel_de_write_fw(display, TRANS_PUSH(display, cpu_transcoder),
> +			  trans_vrr_push(crtc_state, false));
>  
>  	vrr_ctl = VRR_CTL_VRR_ENABLE | trans_vrr_ctl(crtc_state);
>  
> @@ -909,7 +909,7 @@ static void intel_vrr_tg_enable(const struct intel_crtc_state *crtc_state,
>  	if (cmrr_enable)
>  		vrr_ctl |= VRR_CTL_CMRR_ENABLE;
>  
> -	intel_de_write(display, TRANS_VRR_CTL(display, cpu_transcoder), vrr_ctl);
> +	intel_de_write_fw(display, TRANS_VRR_CTL(display, cpu_transcoder), vrr_ctl);
>  }
>  
>  static void intel_vrr_tg_disable(const struct intel_crtc_state *old_crtc_state)

-- 
Jani Nikula, Intel

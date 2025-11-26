Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDCC2DE71A
	for <linux-rt-devel@lists.linux.dev>; Wed, 26 Nov 2025 22:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764197841; cv=none; b=mAVIDKajTrX0Zx1A4azO0TRMkYoS6nSlIOdzCzEfKm94tMmWageVNSG2skI7nW5IUZPzbHwuJB1nI+//zOKPEfYw43ywQ8poKeklDe68rTCp2HV/w8gOme9i3WWyLkpefliPuqp1bfIpJNfCow+Btd4tqv2QAQEYkTBRp+ZKbnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764197841; c=relaxed/simple;
	bh=34LwhM8xnKQMUVjYFt+ey4JPqtzo76IDKcTN6g6SeyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUSXBGXBhzUxEFLnfrZGp5tVRfBgFAcdFxY6OCfGtqwNIT93iX1Vl4+MO58X6MNw/I3ItU8snrMmHPQ3OULop1kQWVWJ5Ph4cZHeIc8Qbajf+QqJC1scqDeIO7WACHM9AJl0OiYqoRJA0UdzFocSFJK0WuvG6Ifh/0DBTQ+Pw5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JOniWtUJ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JOniWtUJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764197840; x=1795733840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=34LwhM8xnKQMUVjYFt+ey4JPqtzo76IDKcTN6g6SeyM=;
  b=JOniWtUJXDxdZ0iYIYH/LzugbUquShz+6mPeCjCyJjAUPIKoza97yZpK
   xFgMi7m+rPV9YqqhHgN5yZpMz2iMp38kObkoWiF3Dc0efmhW8k2KQc7MZ
   iVJaVYU4i4OUq9kAZsSLqCyWq7YjCQ6EFLIzoBS2cHHoEzPa1HQBAAcV4
   GCBM1DB53BY8ComzqoCcmjioPB78Cn2RZSHmpRoeZRa5zxkh54U5E+bMQ
   BJWbvZVEODpXetR48FfQ+HyDVw7RAvbCZHx357qwuq3EurOz3yLECMUV0
   S1xJJZsBsySdVCQw7UVv2z5Bb5ew21iX+G4d1ZayrUG7y8dSxL8LI0rcm
   A==;
X-CSE-ConnectionGUID: fOnym+P7TAeLAdbocmP3zA==
X-CSE-MsgGUID: nV8a0JXBQs69/NJ7A6CH3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="68837958"
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="68837958"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 14:57:19 -0800
X-CSE-ConnectionGUID: 9rY8FkJ8RIydFdzulxtStA==
X-CSE-MsgGUID: H2b33ixOQyuJPZHX8r/wyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,229,1758610800"; 
   d="scan'208";a="197223470"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.205])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 14:57:16 -0800
Date: Thu, 27 Nov 2025 00:57:12 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: "Shankar, Uma" <uma.shankar@intel.com>
Cc: Maarten Lankhorst <dev@lankhorst.se>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	Mario Kleiner <mario.kleiner.de@gmail.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 6/7] drm/i915/display: Enable interrupts earlier on
 PREEMPT_RT
Message-ID: <aSeFyN1iD5CwCZZ6@intel.com>
References: <20251104083634.670753-1-dev@lankhorst.se>
 <20251104083634.670753-7-dev@lankhorst.se>
 <DM4PR11MB63603779042D13B89E36BB02F4DEA@DM4PR11MB6360.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR11MB63603779042D13B89E36BB02F4DEA@DM4PR11MB6360.namprd11.prod.outlook.com>
X-Patchwork-Hint: comment
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 26, 2025 at 08:45:31PM +0000, Shankar, Uma wrote:
> 
> 
> > -----Original Message-----
> > From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On Behalf Of Maarten
> > Lankhorst
> > Sent: Tuesday, November 4, 2025 2:07 PM
> > To: intel-gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org
> > Cc: linux-rt-devel@lists.linux.dev; Maarten Lankhorst <dev@lankhorst.se>; Mario
> > Kleiner <mario.kleiner.de@gmail.com>; Mike Galbraith
> > <umgwanakikbuti@gmail.com>; Thomas Gleixner <tglx@linutronix.de>; Sebastian
> > Andrzej Siewior <bigeasy@linutronix.de>; Clark Williams
> > <clrkwllms@kernel.org>; Steven Rostedt <rostedt@goodmis.org>
> > Subject: [PATCH v2 6/7] drm/i915/display: Enable interrupts earlier on
> > PREEMPT_RT
> > 
> > The last part of the vblank evasion is about updating bookkeeping, not
> > programming hardware registers.
> > 
> > The interrupts cannot stay disabled here on PREEMPT_RT since the spinlocks get
> > converted to mutexes.
> > 
> > Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> > ---
> >  drivers/gpu/drm/i915/display/intel_crtc.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/i915/display/intel_crtc.c
> > b/drivers/gpu/drm/i915/display/intel_crtc.c
> > index 9d2a23c96c61b..b87f6b4a4f3d7 100644
> > --- a/drivers/gpu/drm/i915/display/intel_crtc.c
> > +++ b/drivers/gpu/drm/i915/display/intel_crtc.c
> > @@ -688,6 +688,14 @@ void intel_pipe_update_end(struct intel_atomic_state
> > *state,
> >  	    intel_crtc_has_type(new_crtc_state, INTEL_OUTPUT_DSI))
> >  		icl_dsi_frame_update(new_crtc_state);
> > 
> > +#if IS_ENABLED(CONFIG_PREEMPT_RT)
> > +	/*
> > +	 * Timing sensitive register writing completed, non-deterministic
> > +	 * locking from here on out.
> > +	 */
> > +	local_irq_enable();
> > +#endif
> 
> I think we do have VRR send push etc handled here, also arming registers are being updated.
> Not sure we can allow interrupts here. Please check once

Yeah, this doesn't seem exactly great.

Even without VRR we want the register writes and vblank event arming
to happen in the same frame. Though without VRR I suppose the worst
that could happen is that we complete the commit one frame too late.

With VRR however we need the vblank event arming and push to happen
in the same frame. Otherwise we'll complete the flip early and leave
push send assrted, which causes the next frame to terminate at vmin.
Basically that makes the next frame a mailbox flip as far as push
send is concerned.

The race is already there, but allowing the CPU to get scheduled away
will widen it. We do try to handle it in the vblank evasion, but I
think we're handling it way too early (in intel_vblank_evade_init())
so that part itself is racy. I suppose we should rather do the vmin
vs. vmax evasion decision after we've actually read out the current
scanline. That should at least make it a bit more robust.

One other thing we could maybe think about is arming the vblank
event after the push is sent (with seq = current+1), and then
immediately check if the push bit already cleared, and if so
cancel the arming and send the event directly (with seq = current).
But that's just a quick idead that popped to my head, didn't really
think it through in detail.

I'm tempted to say we should just make the vblank locks raw spinlocks
as well. But I've not looked at what other drivers do in the vblank
hooks so dunno how feasible that is.

-- 
Ville Syrjälä
Intel

Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EE921CC4F
	for <linux-rt-devel@lists.linux.dev>; Mon,  1 Dec 2025 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610777; cv=none; b=bx09mWPyIUebKJIzMZHPZNfHgUaOfavIAWuLu1HfMi9TwxGr7aY9a5BPILy1nHITGfYaIKT1eFHSZGMXSpy64j9nYH4tsr2YRPcnVwTJvuqx1P2mhGbPyDFoJwRuu9IGFGe1lIMXrYBjoVUOCiVULKAVQck2qLgw9lRd6gB/eoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610777; c=relaxed/simple;
	bh=nj69vDfQ1J5Yg610pI7e7INnJWVwsFbGOOnJeRlqGcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OhppsP1KI4UBQrbs2Z6caOYNQFsV1g+nlnMMlyZJ0nIBEN2jZqFyokuZXjpoQqwY7FfxfBKpx0ndOmGRcmG8LNMcSJ+IFtFHLfkmbtBsfiVEzbqsMN/1HpnINGTTZX4BFlJjcDA1K+WjebEgTtKdr3tJIwHgWcGSvVuAABx7t3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=LV4hDDjr; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="LV4hDDjr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1764610771;
	bh=nj69vDfQ1J5Yg610pI7e7INnJWVwsFbGOOnJeRlqGcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LV4hDDjrFj3Vp79lsRSplt3ypNAtHaoO7a8Mvu8Xz3AxckAhN96k0UCuiuNDCcY0D
	 I31qq58lAeaAIQurkMHjhrQGSclVRGj4LdY4NWmw0Tl7xGy5qy5xU7JU+XHZgsZTDg
	 rbNIjR1QiE6y70e7P60OUXIEms3vHz4o+hdIOUsTINMYqBg8lmkaRK6YipTU3L+h60
	 1fOfsDb9VQ43pH1Hx6l4wmZ87MMjSizd8yqzYmKGJe7Hq02cobNAyS6mzhXoufeDmV
	 v3BWdH5F7/hn2QIN/gf7NJjciMX9GFWTngLILp0Pb8RvTgiB9WwObmLPQXkAHU9IFn
	 1x8HktxyBtKnA==
Message-ID: <bb5c566e-6a9e-4d60-be74-b42a751032aa@lankhorst.se>
Date: Mon, 1 Dec 2025 18:39:30 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] drm/i915/display: Enable interrupts earlier on
 PREEMPT_RT
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 "Shankar, Uma" <uma.shankar@intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
 Mario Kleiner <mario.kleiner.de@gmail.com>,
 Mike Galbraith <umgwanakikbuti@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <20251104083634.670753-1-dev@lankhorst.se>
 <20251104083634.670753-7-dev@lankhorst.se>
 <DM4PR11MB63603779042D13B89E36BB02F4DEA@DM4PR11MB6360.namprd11.prod.outlook.com>
 <aSeFyN1iD5CwCZZ6@intel.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <aSeFyN1iD5CwCZZ6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey,

Den 2025-11-26 kl. 23:57, skrev Ville Syrjälä:
> On Wed, Nov 26, 2025 at 08:45:31PM +0000, Shankar, Uma wrote:
>>
>>
>>> -----Original Message-----
>>> From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On Behalf Of Maarten
>>> Lankhorst
>>> Sent: Tuesday, November 4, 2025 2:07 PM
>>> To: intel-gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org
>>> Cc: linux-rt-devel@lists.linux.dev; Maarten Lankhorst <dev@lankhorst.se>; Mario
>>> Kleiner <mario.kleiner.de@gmail.com>; Mike Galbraith
>>> <umgwanakikbuti@gmail.com>; Thomas Gleixner <tglx@linutronix.de>; Sebastian
>>> Andrzej Siewior <bigeasy@linutronix.de>; Clark Williams
>>> <clrkwllms@kernel.org>; Steven Rostedt <rostedt@goodmis.org>
>>> Subject: [PATCH v2 6/7] drm/i915/display: Enable interrupts earlier on
>>> PREEMPT_RT
>>>
>>> The last part of the vblank evasion is about updating bookkeeping, not
>>> programming hardware registers.
>>>
>>> The interrupts cannot stay disabled here on PREEMPT_RT since the spinlocks get
>>> converted to mutexes.
>>>
>>> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
>>> ---
>>>  drivers/gpu/drm/i915/display/intel_crtc.c | 10 ++++++++++
>>>  1 file changed, 10 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/i915/display/intel_crtc.c
>>> b/drivers/gpu/drm/i915/display/intel_crtc.c
>>> index 9d2a23c96c61b..b87f6b4a4f3d7 100644
>>> --- a/drivers/gpu/drm/i915/display/intel_crtc.c
>>> +++ b/drivers/gpu/drm/i915/display/intel_crtc.c
>>> @@ -688,6 +688,14 @@ void intel_pipe_update_end(struct intel_atomic_state
>>> *state,
>>>  	    intel_crtc_has_type(new_crtc_state, INTEL_OUTPUT_DSI))
>>>  		icl_dsi_frame_update(new_crtc_state);
>>>
>>> +#if IS_ENABLED(CONFIG_PREEMPT_RT)
>>> +	/*
>>> +	 * Timing sensitive register writing completed, non-deterministic
>>> +	 * locking from here on out.
>>> +	 */
>>> +	local_irq_enable();
>>> +#endif
>>
>> I think we do have VRR send push etc handled here, also arming registers are being updated.
>> Not sure we can allow interrupts here. Please check once
> 
> Yeah, this doesn't seem exactly great.
> 
> Even without VRR we want the register writes and vblank event arming
> to happen in the same frame. Though without VRR I suppose the worst
> that could happen is that we complete the commit one frame too late.
> 
> With VRR however we need the vblank event arming and push to happen
> in the same frame. Otherwise we'll comple		te the flip early and leave
> push send assrted, which causes the next frame to terminate at vmin.
> Basically that makes the next frame a mailbox flip as far as push
> send is concerned.
> 
> The race is already there, but allowing the CPU to get scheduled away
> will widen it. We do try to handle it in the vblank evasion, but I
> think we're handling it way too early (in intel_vblank_evade_init())
> so that part itself is racy. I suppose we should rather do the vmin
> vs. vmax evasion decision after we've actually read out the current
> scanline. That should at least make it a bit more robust.
> 
> One other thing we could maybe think about is arming the vblank
> event after the push is sent (with seq = current+1), and then
> immediately check if the push bit already cleared, and if so
> cancel the arming and send the event directly (with seq = current).
> But that's just a quick idead that popped to my head, didn't really
> think it through in detail.
> 
> I'm tempted to say we should just make the vblank locks raw spinlocks
> as well. But I've not looked at what other drivers do in the vblank
> hooks so dunno how feasible that is.
> 
Ideally we make the time critical code even faster, and fastest is
pre-obtaining the vblank locks so no race is even possible in the timing sensitive part.

If we acquire a drm_vblank_get() and dev->event_lock before we begin
vblank evasion, and release them afterwards then no conversion of the
lock to a raw spinlock is required.

This eliminates even more jitter, and turns the support of PREEMPT_RT
in something positive. :-)

Kind regards,
~Maarten Lankhorst

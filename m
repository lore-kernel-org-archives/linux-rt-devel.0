Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668162F25F8
	for <linux-rt-devel@lists.linux.dev>; Mon,  1 Dec 2025 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764598941; cv=none; b=u0wknrDXAtza4rhKKe7G0C/3bS+imlIVHFW6dj4UjJ7tLTZstZGpcnMWsxgIfSxMzukdMA6cUwRJkY38LbUhJnWiTxgCZI1QLP9uHzZvSI0AMJKGo1oreFvUWsf9307x2VaFgQnrrCWo4nKm/D/CFpXl+6AbQI7WYrZk47fZb40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764598941; c=relaxed/simple;
	bh=1nkqSC0wNwR0rPdu30G4UPJ4xAY8what6wXy8xY49Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FpjDFfWkDnMouQAPpVTEQrHiQ5rCZWkPuB6O2PZ0eXK10lORyxmYp9m3jKO6Vkph9C234Dsgch+vAJYLjM+2GjCGKb/ibAB2wmRjiTb3PeRNadGYOwXU773hnzGFwYfvItsSuI/K9KZOstegctu6MJup8ufz/NnCgE+13HtsQw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=gPPNTZZp; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="gPPNTZZp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1764598396;
	bh=1nkqSC0wNwR0rPdu30G4UPJ4xAY8what6wXy8xY49Fk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gPPNTZZpHgNFam1wKG6o6d3bF4N1JY457es94STH1sv3zD3wZJNKMGHMw4jPYKPRV
	 Uoi82Y8paAtR2M005wcBnNHP09keEtM3vrmE3/pr3bnzwVFoz7w1Ulp9QRNWMETBpi
	 +hoKnIQwuyFC5ARmmZXPXJvzbh7Y28MzjZ7K3B9lFWjDOGzZu34pYun++BhNMPCS5m
	 zCBNdGZGZ+dB/ox8McewaWS5j78x1x4it4u+S8VD1mEv7j8laIDK+NV5hO7TqsozKz
	 DkqdDCpxDnFY6H12Z0vJ3fd1ZT03Xq7jDPV/s/ZqKoucjRjFVoH9OnbDyXAZwNMsH/
	 Tr0onoRf+UDCQ==
Message-ID: <c47fc4e3-79b9-4a57-95cc-aaeb608b3435@lankhorst.se>
Date: Mon, 1 Dec 2025 15:13:15 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] drm/i915/display: Remove locking from
 intel_vblank_evade critical section
To: "Shankar, Uma" <uma.shankar@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Cc: "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
 Mario Kleiner <mario.kleiner.de@gmail.com>,
 Mike Galbraith <umgwanakikbuti@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <20251104083634.670753-1-dev@lankhorst.se>
 <20251104083634.670753-5-dev@lankhorst.se>
 <DM4PR11MB63604FC52C88FCDE1176FA25F4DEA@DM4PR11MB6360.namprd11.prod.outlook.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <DM4PR11MB63604FC52C88FCDE1176FA25F4DEA@DM4PR11MB6360.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hey Uma,

Den 2025-11-26 kl. 21:03, skrev Shankar, Uma:
> 
> 
>> -----Original Message-----
>> From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On Behalf Of Maarten
>> Lankhorst
>> Sent: Tuesday, November 4, 2025 2:06 PM
>> To: intel-gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org
>> Cc: linux-rt-devel@lists.linux.dev; Maarten Lankhorst <dev@lankhorst.se>; Mario
>> Kleiner <mario.kleiner.de@gmail.com>; Mike Galbraith
>> <umgwanakikbuti@gmail.com>; Thomas Gleixner <tglx@linutronix.de>; Sebastian
>> Andrzej Siewior <bigeasy@linutronix.de>; Clark Williams
>> <clrkwllms@kernel.org>; Steven Rostedt <rostedt@goodmis.org>
>> Subject: [PATCH v2 4/7] drm/i915/display: Remove locking from
>> intel_vblank_evade critical section
>>
>> finish_wait() may take a lock, which means that it can take any amount of time.
>> On PREEMPT-RT we should not be taking any lock after disabling preemption, so
>> ensure that the completion is done before disabling interrupts.
>>
>> This also has the benefit of making vblank evasion more deterministic, by
>> performing the final vblank check after all locking is done.
>>
>> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
>> ---
>>  drivers/gpu/drm/i915/display/intel_vblank.c | 35 ++++++++++-----------
>>  1 file changed, 17 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_vblank.c
>> b/drivers/gpu/drm/i915/display/intel_vblank.c
>> index 2b106ffa3f5f5..3628d2a1b8f38 100644
>> --- a/drivers/gpu/drm/i915/display/intel_vblank.c
>> +++ b/drivers/gpu/drm/i915/display/intel_vblank.c
>> @@ -708,6 +708,13 @@ void intel_vblank_evade_init(const struct
>> intel_crtc_state *old_crtc_state,
>>  		evade->min -= vblank_delay;
>>  }
>>
>> +static inline int vblank_evadable(struct intel_vblank_evade_ctx *evade,
>> +int *scanline) {
>> +	*scanline = intel_get_crtc_scanline(evade->crtc);
>> +
>> +	return *scanline < evade->min || *scanline > evade->max; }
>> +
>>  /* must be called with vblank interrupt already enabled! */  int
>> intel_vblank_evade(struct intel_vblank_evade_ctx *evade)  { @@ -715,23 +722,22
>> @@ int intel_vblank_evade(struct intel_vblank_evade_ctx *evade)
>>  	struct intel_display *display = to_intel_display(crtc);
>>  	long timeout = msecs_to_jiffies_timeout(1);
>>  	wait_queue_head_t *wq = drm_crtc_vblank_waitqueue(&crtc->base);
>> -	DEFINE_WAIT(wait);
>>  	int scanline;
>>
>>  	if (evade->min <= 0 || evade->max <= 0)
>>  		return 0;
>>
>> -	for (;;) {
>> -		/*
>> -		 * prepare_to_wait() has a memory barrier, which guarantees
>> -		 * other CPUs can see the task state update by the time we
>> -		 * read the scanline.
>> -		 */
>> -		prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
>> +	while (!vblank_evadable(evade, &scanline)) {
>> +		local_irq_enable();
>>
>> -		scanline = intel_get_crtc_scanline(crtc);
>> -		if (scanline < evade->min || scanline > evade->max)
>> -			break;
>> +		DEFINE_WAIT(wait);
>> +		while (!vblank_evadable(evade, &scanline) && timeout > 0) {
> 
> Not sure if doing the scanline check with interrupts on is ok. The scanlines can move
> if we get interrupted or what happens if we get a vblank interrupt. Looks vulnerable to race.
> 
> I will try to check this further and get back.

There is a double check here to make it safe:

while (!vblank_evade()) {
	drop locks();

	while (!vblank_evadable())
		wait();

	re-acquire locks();
}

Even if the middle vblank evadable is unsafe, and it has to be to be able to wait, we re-check after acquiring locks.
We must do so there anyway since the locking acquire can add any amount of latency as well.

Kind regards,
Maarten Lankhorst


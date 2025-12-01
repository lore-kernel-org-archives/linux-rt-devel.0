Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4512629D28A
	for <linux-rt-devel@lists.linux.dev>; Mon,  1 Dec 2025 17:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764611008; cv=none; b=cNNaYtOPXYEcHHmPDibcvP2aDSRJRAxOfXwBoED9rKTzdQMw3YOtGJTtF0ENePA07Spwr2qhef9no8yrxUW7PCYoVxJyWaRhfGfFMe5t9DdKQh625uVbY3OzIsyfPIWi9Wn5RuNymjyPiAOavTBjjygoCVbMlzClCuREmNQaVEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764611008; c=relaxed/simple;
	bh=BxsDMISbQaxID58sHXEnj5BiEwpTY+LpadDzPx4lhb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qaUphk7x9a7kAB42DCzYgmUVOYYV9fFrnmuU4FDhCUxLdnVcPesGHg6omtnQ7vs8HjuR7+t2dEkv+MFdrqanCD0FEZKRM5SKkiBjbNQZN7/PhlFthcteIZzVd4kOHUTc3UM5NUAywBJP27XFLGRvjhwTxe3OwEm9y6IDT3OjLRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=O2mkU5pi; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="O2mkU5pi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1764611004;
	bh=BxsDMISbQaxID58sHXEnj5BiEwpTY+LpadDzPx4lhb4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O2mkU5piUNT4OBKWPiULKjn7UM17dn4aArrm5TYlYkGumURqjrmfpE1UHNxMHlh3X
	 qT/vnpiEl5JysI5RNJVlB0vRkKElSV9IZ9RPS4/rbY+Hi+AZms6M8SWN40UwkYrU5U
	 ZKYAcdRLSnkJdT9C4Qewb4WV9WGrYmRyMt6eBd2FmS/lVrPfBgYSW3vuscKeRh0YGj
	 Iy2Rw1QqJ+3zdpBahYpjxnMhTTT2IC6nWRR8y/NVy7sdl4ALwvhWMGwSCtFPICmuwa
	 t4Fy4un+OwPLxAQ2lhJI8OXBkY4FvfLIvjFfsxCG5Cg4db9Qe+leETRoP0rSpyISg3
	 olBJUoPSjOlzw==
Message-ID: <e3cbdd41-951b-4e4d-9d47-3e0cb1a9fb45@lankhorst.se>
Date: Mon, 1 Dec 2025 18:43:20 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] drm/i915/display: Use intel_de_write_fw in
 intel_pipe_fastset
To: "Shankar, Uma" <uma.shankar@intel.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
 Mario Kleiner <mario.kleiner.de@gmail.com>,
 Mike Galbraith <umgwanakikbuti@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <20251104083634.670753-1-dev@lankhorst.se>
 <20251104083634.670753-3-dev@lankhorst.se>
 <DM4PR11MB63609A43C9B11091A5FB41EFF4DEA@DM4PR11MB6360.namprd11.prod.outlook.com>
 <aSdYPKUJgbe84G1M@intel.com>
 <DM4PR11MB6360D148BD7067E0BF59656AF4DEA@DM4PR11MB6360.namprd11.prod.outlook.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <DM4PR11MB6360D148BD7067E0BF59656AF4DEA@DM4PR11MB6360.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey,

Den 2025-11-26 kl. 20:56, skrev Shankar, Uma:
> 
> 
>> -----Original Message-----
>> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
>> Sent: Thursday, November 27, 2025 1:13 AM
>> To: Shankar, Uma <uma.shankar@intel.com>
>> Cc: Maarten Lankhorst <dev@lankhorst.se>; intel-gfx@lists.freedesktop.org;
>> intel-xe@lists.freedesktop.org; linux-rt-devel@lists.linux.dev; Mario Kleiner
>> <mario.kleiner.de@gmail.com>; Mike Galbraith <umgwanakikbuti@gmail.com>;
>> Thomas Gleixner <tglx@linutronix.de>; Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de>; Clark Williams <clrkwllms@kernel.org>; Steven
>> Rostedt <rostedt@goodmis.org>
>> Subject: Re: [PATCH v2 2/7] drm/i915/display: Use intel_de_write_fw in
>> intel_pipe_fastset
>>
>> On Wed, Nov 26, 2025 at 07:19:47PM +0000, Shankar, Uma wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Intel-gfx <intel-gfx-bounces@lists.freedesktop.org> On Behalf
>>>> Of Maarten Lankhorst
>>>> Sent: Tuesday, November 4, 2025 2:06 PM
>>>> To: intel-gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org
>>>> Cc: linux-rt-devel@lists.linux.dev; Maarten Lankhorst
>>>> <dev@lankhorst.se>; Mario Kleiner <mario.kleiner.de@gmail.com>; Mike
>>>> Galbraith <umgwanakikbuti@gmail.com>; Thomas Gleixner
>>>> <tglx@linutronix.de>; Sebastian Andrzej Siewior
>>>> <bigeasy@linutronix.de>; Clark Williams <clrkwllms@kernel.org>;
>>>> Steven Rostedt <rostedt@goodmis.org>
>>>> Subject: [PATCH v2 2/7] drm/i915/display: Use intel_de_write_fw in
>>>> intel_pipe_fastset
>>>>
>>>> intel_set_pipe_src_size(), hsw_set_linetime_wm(),
>>>> intel_cpu_transcoder_set_m1_n1() and
>>>> intel_set_transcoder_timings_lrr()
>>>> are called from an atomic context on PREEMPT_RT, and should be using
>>>> the _fw functions.
>>>
>>> This could be ok but we need to be sure that all are called with power domains
>> up.
>>> I think would be safe to keep this under RT check so that we don't end
>>> up breaking any generic non RT usecase.
>>
>> When removing the locks from register accesses one needs to consider what
>> platforms the code runs on, what other register are on the same cacheline, and
>> whether they can be accessed in parallel. If there is something there then we may
>> not be able to remove the locks.
>>
>> That's assuming the "system hangs when same cacheline is accessed from
>> multiple cpus" issue is real for display registers, and I'm actually not 100% it is.
>> But we'd need to run some tests on the affected systems
>> (~ivb/hsw) to get any kind of confidence here. IIRC some old intel_gpu_top thhat
>> directly poked the registers was very good at hitting it on hsw at least, so that
>> would be a decent starting point.
>>
>> Anyways, I'm going to be replacing the uncore lock with a display specific lock
>> soonish, and I suppose I can just make that a raw spinlock to appease RT.
> 
> Thanks Ville, yeah I am also not confident to switch to the fw version. Even if we have
> to try this should be made limited to RT cases, where we can contain and stabilize as
> we test and find out any issues.
> Direct poking of registers requires root privileges, so that should not be something we have to worry about. It's not something required by any driver.

The specific calls are called during modeset, fastset and pageflip, and by design there is no chance of those racing with each other. They're serialized between each other.

Kind regards,
~Maarten Lankhorst

Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1424A387572
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014127; cv=none; b=LFXTZ60UMCOPGjjFJouDQYOUK5391iu/0F1UAaFc4GUh9kbQuJDxqU+c/L3L2Pgkkk4wCkB+YJsnBFkLr7pavSbw0bY+VYBdDyggUOgqr4ZUuMUg6qUKIc7UpwxPkbvojHLeqQE/u2z202d5/q7yWBVLNVt2Gy1RaoZdbK/fKss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014127; c=relaxed/simple;
	bh=cLD3HoYvuFQ+SGw//VXGJTuIKP/DCkVorY5/YG3bIGA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Wvy3p2W9VuQkm/RYlfoitgIxo8HrQX3sRrMtdTbzifcxDMyeoV9N9arpN3tIv0ItejElZtCnaApXYOGCWjzFTcdm6pGzQab6hI9BZeZYrGcRoQB0ZIukQug7FjR5NM+JNMuy93QC5NHUFiG9k+x1+zJgZNWpg236aiLwu8YVHAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cPgf5a0E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPgf5a0E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769014125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CncJ+F7A6Y9Hl4XUc7kG12VL4QgJfQ/zB+kPL7VLBrc=;
	b=cPgf5a0EM5zs9Oz6FuEymkTZ9lTlJ6FOqHlRi8IsFCFtPJHKo0Rap6N32HfTLlquAB5Yiq
	ALpxasOjmlsNmN1+/o3Br5JKg15qvw2Y3BpTnnrhUTL97qCJ9IhGdvyJUrWvAwpS/0JOS8
	QmGhdKcsIk6yVgKe7Qj4mkrU0Yxairo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-8add_8trOfWACpELj_H3gw-1; Wed, 21 Jan 2026 11:48:43 -0500
X-MC-Unique: 8add_8trOfWACpELj_H3gw-1
X-Mimecast-MFC-AGG-ID: 8add_8trOfWACpELj_H3gw_1769014123
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-89471079a13so4286136d6.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 08:48:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769014123; x=1769618923;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CncJ+F7A6Y9Hl4XUc7kG12VL4QgJfQ/zB+kPL7VLBrc=;
        b=Vx1UVi7GD8dWHTMMODqO65uh0VLVrumLYSbwe1YONeMHEALC0n1ZLxStG7Sf9l3R8M
         aQPos8RYAbAwoCBdsqTcIoV1TBFEL/95sg8KZDniJt3/8N8QoRVmN35wp4f/+uVblnto
         bCeUT0ykoE+4xT3sJeWjNujaBQHr+44QJmOuL+5DIHwOAZiismqrmB0mqEMWPDcmRFHx
         xw4dS4rqCMRxY+WHLYo5ORnNtII5QjAWOKdNJHT8F8x/CUEw8MGJdaDCMbgIQEtm4psV
         RK4QUeiPBOG3s7CaFCnwVkcoW27mm+RO4i1UE1oaZPTJfzWitZcjfT/5S3hUK303e6aI
         s1fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXp8aQxF5MEO0vLrpNbZ/PA1Q0hHlVzbMjzUt8sg0aPpOuE/0uPZ/fzGMxUHlfp5QkSUv4TdK8EawDi/v5BRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYOpM80npADPN3HQ8VhyahvtCxeMsoMQU5I2Vmvj9AlUqvMjSS
	BZYu8a8VYRz3s2SOWfaKbweq9323ctngKbdsi749kWvd4mqQi3Pbc28xf+0DsT3VSHjQpZyYoCn
	mHfZQl9hLF0cB5ZEiv5QoEQSUL3e9pBl8eral/dmVsQS+eW/RjepR3AL1kerYMNJ6zLyS
X-Gm-Gg: AZuq6aIOJoRl0H1pOjr3jkh3P5tcxVhwGv5yFPrMFLCxOAKfcsLT+dMfZplDfkp0QAy
	O8fh9NSChlj3rDioGzot8zbS1ZIRvU6PJjyQYJk9umgKBxx8y7PXtT3MHM1Y9jI1wvhY7lq9Iko
	Mzs6wxFgFH67cojJfhaH59D6ySfRLSbBuUd89HyBDGw7ZruH+/656Bgx4rSLDsfYOsW0gWC4A1/
	85rc7AucWT5LSQno4aJI6CsWROtL6I2BH5uO6GpawzciRMl0NJPk2/bLzLmgFdc0r8OGmjBNQgt
	6wjzPRDLc4cYBTiJGTbGCegR51abxJY0AcFDNPp5yLsey/8nBV1u+fF5NW5e172aoWumwnPZUlk
	/CchlNzNSQ1xhHjysqRf68wD1kfajEzXIWOLdGnaCZ5n4p+mWSCMrJQy9
X-Received: by 2002:a05:6214:c8b:b0:87c:2900:1f97 with SMTP id 6a1803df08f44-8942e531c13mr267613256d6.44.1769014123139;
        Wed, 21 Jan 2026 08:48:43 -0800 (PST)
X-Received: by 2002:a05:6214:c8b:b0:87c:2900:1f97 with SMTP id 6a1803df08f44-8942e531c13mr267612976d6.44.1769014122782;
        Wed, 21 Jan 2026 08:48:42 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6040casm134934466d6.21.2026.01.21.08.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 08:48:42 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0bada1e3-f312-4b72-974c-4b061e577d66@redhat.com>
Date: Wed, 21 Jan 2026 11:48:41 -0500
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't acquire rt_spin_lock in
 allocate_vpe_l1_table()
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260107215353.75612-1-longman@redhat.com>
 <864iowmrx6.wl-maz@kernel.org> <87ms2nsqju.ffs@tglx>
 <86wm1qlq7l.wl-maz@kernel.org> <87ecnwij44.ffs@tglx>
 <86v7h8l9ht.wl-maz@kernel.org> <87pl7gglya.ffs@tglx>
 <86tswrkrh4.wl-maz@kernel.org> <861pjjcqdi.wl-maz@kernel.org>
In-Reply-To: <861pjjcqdi.wl-maz@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mavTzJAjZm9Pxzf_QFEJND__5dlAqJ22f8Lj8uFKW6E_1769014123
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/21/26 3:38 AM, Marc Zyngier wrote:
> On Mon, 12 Jan 2026 11:20:07 +0000,
> Marc Zyngier <maz@kernel.org> wrote:
>> On Sun, 11 Jan 2026 16:20:45 +0000,
>> Thomas Gleixner <tglx@kernel.org> wrote:
>>> On Sun, Jan 11 2026 at 10:38, Marc Zyngier wrote:
>>>> On Sun, 11 Jan 2026 09:39:07 +0000,
>>>> Thomas Gleixner <tglx@kernel.org> wrote:
>>>>> On Fri, Jan 09 2026 at 16:13, Marc Zyngier wrote:
>>>>>> On Thu, 08 Jan 2026 22:11:33 +0000,
>>>>>> Thomas Gleixner <tglx@kernel.org> wrote:
>>>>>>> At the point where a CPU is brought up, the topology should be known
>>>>>>> already, which means this can be allocated on the control CPU _before_
>>>>>>> the new CPU comes up, no?
>>>>>> No. Each CPU finds *itself* in the forest of redistributors, and from
>>>>>> there tries to find whether it has some shared resource with a CPU
>>>>>> that has booted before it. That's because firmware is absolutely awful
>>>>>> and can't present a consistent view of the system.
>>>>> Groan....
>>>>>
>>>>>> Anyway, I expect it could be solved by moving this part of the init to
>>>>>> an ONLINE HP callback.
>>>>> Which needs to be before CPUHP_AP_IRQ_AFFINITY_ONLINE, but even that
>>>>> might be to late because there are callbacks in the STARTING section,
>>>>> i.e. timer, perf, which might rely on interrupts being accessible.
>>>> Nah. This stuff is only for direct injection of vLPIs into guests, so
>>>> as long as this is done before we can schedule a vcpu on this physical
>>>> CPU, we're good. No physical interrupt is concerned with this code.
>>> That's fine then. vCPUs are considered "user-space" tasks and can't be
>>> scheduled before CPUHP_AP_ACTIVE sets the CPU active for the scheduler.
>> Waiman, can you please give the following hack a go on your box? The
>> machines I have are thankfully limited to a single ITS group, so I
>> can't directly reproduce your issue.
> Have you managed to try this hack? I may be able to spend some time
> addressing the issue in the next cycle if I have an indication that
> I'm on the right track.

I am sorry that I was busy working on other stuff. Will try out the hack 
today and report back ASAP.

Cheers,
Longman


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD273E9F67
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 20:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769028088; cv=none; b=CMsFoMDG+3aq3x/xRXjBDhBnyMTu1kSHjspVCJHzxCzMYEP9D0nB8NfJkFG2BFrqhD4MF1UzmintLU/yCzXov3kN9QuzP+a9v2chWeVRBNEitSwGniw2MCSSRjjkCS7C2yshbOl21RaZ/eLmTFfQHHMD4Gau0OCSSzaSQD7J6EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769028088; c=relaxed/simple;
	bh=G3acNzLE+XKGua3haS9Yxlfx4qhRbVjE8ziDWKoielA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Trmx34eKhprm9MoqwrcKoUlZwUsB9k3XVd2v+Ys3pS9FjufKDIn9UoZQQ2aO8ST/rS2N6SVRw2m096hq3cVxKocTSnXGt2lKfbqwcfddN402joljmwFNPAD5ZL6p+pgcsQ6r3FNjhSuZPHAn8rnavkHCZ0vMDJWr3k7+sfPdsDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OTXFNIlA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTXFNIlA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769028085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=djpJyuMScmlBrHd91p9Wz9+Dh8n8NY06xyptDyrXdV4=;
	b=OTXFNIlAE6Lt28ILP529e/QyLrg645Hd/XxuZvJBOmTgf6nSWICV4/E3VdHOCJulj0Dbnc
	rYu+76akzCFG0mWsoXBHjqeL2AhJKJvfIa8abcLkpQSDFIrJ5J0MzHQBZVmyrOywKC4zhG
	5uMFxBoDA5oet+K6W0s8uICN5zlfedA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-R8vkP_wPMCqJLb7DsXuwsQ-1; Wed, 21 Jan 2026 15:41:22 -0500
X-MC-Unique: R8vkP_wPMCqJLb7DsXuwsQ-1
X-Mimecast-MFC-AGG-ID: R8vkP_wPMCqJLb7DsXuwsQ_1769028082
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8ba026720eeso79318585a.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 12:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769028082; x=1769632882;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djpJyuMScmlBrHd91p9Wz9+Dh8n8NY06xyptDyrXdV4=;
        b=rZavvprv0P+JLnMaNs36aRtLqLlhfs3vHm0Sk1z4t3ffzh+CTIal4YpvikqyircDKa
         wdEkQ/tiu5HPGyvnII9LhdR8rUH/z63d/+vnwGsq7i/MOGrh8aTxRbNK01fdpVOIC37Q
         nS2JhTiy3iNVz0YzH4WAePkIrD5Npwh9uuV+nbpUu81HLNbjeaJE+RJhlKeUDR+/hTvv
         o+nJMCnmnNWDYl+X02fmrZYDyZh75qpn0GAlzBgGYlfVRjGJdgWViUiA3du68X4kNG7u
         9DH8iVdvV2dkpo4RavApw+tq8WzGiauRE7bu2oiwsR7SvxKBAB47sDvLiiaP+RrLMDId
         +FuA==
X-Forwarded-Encrypted: i=1; AJvYcCWLPElbBCnEVdzrQa+7t9w4ywTNSqhjQoTNEYEsqYc2ZC5x0Ijyj4BWvzOoSCZyS7Qk+Aqcp4/cjpE8xq5xSw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6oU1QS1ggnIxz2BMBQ1pMf4TKoIxTG/y7EhUlfrb/2C3nNX2f
	gOvqLFPfI4W7ARLiPlDSMSPdT8yE1IbthsrXe78jUwocYqk02I5eY/n/1Po60wx3YwEbX1m1g+2
	6PUqmY6vFabEtHnEzDX9mYPga1KPiOuLO909z9YokZB1goyG6cvKlOunAtHhucsEgC6AV
X-Gm-Gg: AZuq6aKIs7FSeYszdCOmF2kIvQ9+257PA24Crafu5NJA+nTlnTs1OHD6TkbUFI3jIYR
	xSGK4A5/lYgRmIBxhNNbe++P6wexb1LrAsfyRQsXMie6j85dlJrleWG5nIG4E8lB3NIMzuaI2tL
	EzBpeRRfzlhm+5H52+WRvnEFBT8FQrBJb0JIDApyJ0v5ofB/xsRK2V6pITYWc1kPjRKM/aclJPW
	Hz+JRWdnrvuX1rfH6xMFpTp3MRQy9E4sfYZw0L18dQBnudL9SjZkcZmSCeY4hpMves1FGsn00+Q
	w8GB6Vy8zVwn6ZXdAP6ssdI80tynTfweNkCueSuX+uLSrko7cQ/md8DTff+ExD3M8OBV3dDWjx/
	uqZmFnxy7miNzEAYUm7Z+9JExmj3TgDVQmX44PEbw9GsFL+m34Wzo5S3Z
X-Received: by 2002:a05:620a:4714:b0:8c6:a628:8608 with SMTP id af79cd13be357-8c6a66d1d82mr2524754985a.6.1769028081669;
        Wed, 21 Jan 2026 12:41:21 -0800 (PST)
X-Received: by 2002:a05:620a:4714:b0:8c6:a628:8608 with SMTP id af79cd13be357-8c6a66d1d82mr2524752485a.6.1769028081250;
        Wed, 21 Jan 2026 12:41:21 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6b22bb7cbsm1036983185a.39.2026.01.21.12.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 12:41:20 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4dc6ab03-b2ad-4411-a49b-4513c5d592ea@redhat.com>
Date: Wed, 21 Jan 2026 15:41:19 -0500
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
X-Mimecast-MFC-PROC-ID: s5NYZ6G385SARcw3eIW6zEFIjBqAgEGjbO34L7E1-2M_1769028082
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

Yes, I have tried out your hack patch and the 2-socket Grace test system 
booted up without producing any bug report for a RT debug kernel. I will 
try out your official patch once it come out. So moving the memory 
allocation to a later part of the hotplug bringup pipeline where 
sleeping is allowed should work.

Cheers,
Longman


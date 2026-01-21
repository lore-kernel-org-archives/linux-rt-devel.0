Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E1A3A0B06
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013477; cv=none; b=kZ/LY+LVW4tQydP1T9agXQEas65EI/rqMG/Q8H3xPlUBReR1xmDU3tK6lpbWetkPKdamEZtDIupulAHIHEVveAd0qFnfpMG9W22tymtZCfdFwczgz9GWMK8dlgCilKm6kMj1rii3c8wxAgDESwbF1HBa6ekzM6xdHgcWH2VntfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013477; c=relaxed/simple;
	bh=48ia2v3JvlOoKCwQlwuT5sa+4oBF3tNUgD1Op0bhI5M=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=pU7KhqOZI8q1AYmx5YSkpamMd00/qiPr/iOmFM/MJHTC5fLAhvDluxpiXz/YfypyJx7ZMWi0d17RKcrYH6xJa0EFFAloakoaSTUOfeHHGJ2ZjOTsAC3VkpI3pMgdXos7tMZSiDC0u2cWeK4ghnaHSAk9ZHevLoiCnCW838vrV+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FkcWFzPo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkcWFzPo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769013474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Fl9BeRxb0RlVEI0fxpQpvxpYW4ryPPVgf7Ef4kRGPU=;
	b=FkcWFzPowlviHyw23aTyP1bdNaY3Dkvpkyra/0VENQW/WomLJF+GXmRLzKuQUDHCR8NCaF
	Pn/S3Cb8Fpbu2AQIOVq6DOY0soqo+uvawxHv3sivzpWZ2pKkkn9YnWRFi2zgko3gusNkid
	G86x0+ThGbMn9Cn6W27k5iUl+WEg8C8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-PNhyaXj1Nci3lW6CbCh_RQ-1; Wed, 21 Jan 2026 11:37:52 -0500
X-MC-Unique: PNhyaXj1Nci3lW6CbCh_RQ-1
X-Mimecast-MFC-AGG-ID: PNhyaXj1Nci3lW6CbCh_RQ_1769013472
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88a360b8086so1784266d6.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 08:37:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769013472; x=1769618272;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Fl9BeRxb0RlVEI0fxpQpvxpYW4ryPPVgf7Ef4kRGPU=;
        b=ZHbN06evRnd1qcBtXYd3Fy/jC1HJ6qrzzg00revjL1xodT/L4BQKaEVnT/AfeVLsHI
         L9KQrOxYs3FGsXBACeYP/C5bmIEzCh9JIuFSXGddKUs9rSJFT356iMpGH7MLqvVtCc3e
         NXv0G+/w3VvFNetVaQ7WiZZmX4NK2aaCbfbSM6THS4t1112edKp/Mgx801dckR16sOlO
         iZttUFE5iam73Du/+lSCJqca7HwlSk+WyDOjQ8F7roHm0YEXqsGsWDY0IbRAke1vVhKN
         FHp2qSC1HdVV9rrrsojbqwqUheMz/VyNnq9nSLFfuQJO3us+pIhKIip/Tvf93CkRN5ov
         LZrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjpWgLgqqPWS+kVx44Vj6rScTSI779ym395NcZ7lM01BJBlymTycrfaeA3RhlKwH0XgyWeZCvyAUsEZ7yagg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzysPatTp12iWKM3WsEyh3n0+yERZU8KLaUkcuw4RwxhfJKVSaV
	asiTfaaZlehEPeIqSMDotraLp6EVEQBV2hYSjLsYy/TZnCFiwI6vpgQs8iuRrK7SOayNBFL5c1y
	4NeeWZbJKkFQgV2sPTeckBWZAHKmjtWoiEl7ZYkd8MZByVS6/CiwEWYNGBzQrk+e3kl5i
X-Gm-Gg: AZuq6aJCC0NAe7g5kecy2RL2iLDGIdkj+LEDdanAza82Oo6pc1vC9B3BkLbvF1qck8G
	9+97apU766AgwaThRk2PeXq6mxupEgbUHouTzaKTdG4PxixAutbw3WWe+91277BmLkNyZIQZg4M
	PD1H8/NUzT27JUqPdsesDxawrSn8tTYvqmrC79XNNhevpzRzru/ofYQs1Ttz8KSI3opXHCOP9uZ
	24Cm12zgq1OT1tTLqFJDjXaOVmOwSraRzAvwm5l+ih7ha66aAP7UpLEytkBtzwDNfxOzNuAl8kR
	W/iPxnrqopdFXLjfu3BxixwlsOFTEb4T+5w6RAIV8hlsaHwjkDg7/jS4Rxf/bSqZfhAGzUpsf6o
	cgHLNm2wb2/bbiHRK1R0i8+nik5qAPSo1XlRqo0Fsepp1EtcDPgcsGp2n
X-Received: by 2002:a05:6214:2aa8:b0:888:23a9:7b01 with SMTP id 6a1803df08f44-8942ddadaa4mr271203896d6.42.1769013472290;
        Wed, 21 Jan 2026 08:37:52 -0800 (PST)
X-Received: by 2002:a05:6214:2aa8:b0:888:23a9:7b01 with SMTP id 6a1803df08f44-8942ddadaa4mr271203576d6.42.1769013471819;
        Wed, 21 Jan 2026 08:37:51 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e5e4a3csm133070566d6.5.2026.01.21.08.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 08:37:51 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f8ba00be-d98c-4962-a32a-98ac0ddef9b2@redhat.com>
Date: Wed, 21 Jan 2026 11:37:49 -0500
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't acquire rt_spin_lock in
 allocate_vpe_l1_table()
To: Vlastimil Babka <vbabka@suse.cz>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Waiman Long <llong@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Alexei Starovoitov <ast@kernel.org>
References: <20260107215353.75612-1-longman@redhat.com>
 <864iowmrx6.wl-maz@kernel.org> <87ms2nsqju.ffs@tglx>
 <86wm1qlq7l.wl-maz@kernel.org> <87ecnwij44.ffs@tglx>
 <86v7h8l9ht.wl-maz@kernel.org>
 <40cec799-f363-4642-969b-24f5a2d56dfb@redhat.com> <87cy3eg94y.ffs@tglx>
 <5f4bfd8b-8699-4bef-bf49-f29965e95ca4@redhat.com>
 <20260113115515.98Mc29Nm@linutronix.de>
 <0c33bdee-6de8-4d9f-92ca-4f72c1b6fb9f@suse.cz>
In-Reply-To: <0c33bdee-6de8-4d9f-92ca-4f72c1b6fb9f@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oh_T05Llu-_tFBfyqwCTlCfnKbsTiVaWz4I3qPd5LQU_1769013472
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/26 12:59 PM, Vlastimil Babka wrote:
> On 1/13/26 12:55, Sebastian Andrzej Siewior wrote:
>> On 2026-01-12 12:14:30 [-0500], Waiman Long wrote:
>>> On 1/12/26 10:09 AM, Thomas Gleixner wrote:
>>>> They might be acquired though. Only alloc_pages_nolock() guarantees that
>>>> no lock is taken IIRC.
>>> Thanks for the suggestion. I will look into using that for page allocation.
>>> I had actually attempt to use kmalloc_nolock() to replace kzalloc()
>>> initially. Even though it removed the call to rmqueue(), but there were
>>> other spinlocks in the slub code that were still being acquired like the
>>> local_lock() or the spinlock in the get_random() code. So I gave up using
> Hmm if get_random() code takes a spinlock, we have an unsolved
> incompatibility with kmalloc_nolock() and CONFIG_SLAB_FREELIST_RANDOM.
>
>>> that. Anyway, kmalloc_nolock() doesn't seem to be fully working yet.
>> with kmalloc_nolock() you have to be able to deal with a NULL pointer.
> Yes. So even after we fix the current problems with incompatible context, I
> think kmalloc_nolock() would still be a bad fit for hw bringup code that
> should not really fail. Because the possibility of failure will always
> exist. The BPF use case that motivated it is quite different.

Yes, it is an issue too that kmalloc_nolock() may fail. If that happens, 
we don't have another good alternative.

Cheers,
Longman


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862889;
	b=G5Ir5ZKfn/ZcAB9fcJx9CJJj0p7+Jqws7wwu/mlyjdZY5liiuKWsDvQYvm8LiGg6Chcy
	 JG/eO3dYJrc+gCFYpoUTZhQnxUbZk5R9eiqwBSpnmjRwC36buMrqy7EFaL7UITcqoDFOm
	 k2iVpF/CAHA6vIk3Hnlso5zVDLyz69SC9Nk184xZ+8PCLVzEFVNUcf3g55stnumLVOi31
	 LYfHmqzj3itDYAuTmfWIGbcM2s3GJ6WzRvvKTC4myfaMtE0sBkDR0NitsZAd8L0Jwc29M
	 lLKkk1/bhdSfBsNMaXtzIleWXHpqVHvNOm/qOwlrAebCIrBa/C9PlitHe3DzMZNyh8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862889;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=cZkitsX+DewrI5AYsqUlHktt4nU0q8Qh/L8/eegqT0M=;
	b=wd1+76JMYV5Lqu2k4AqlpfuVNWqrR7N2xDAnev4v4Fom2njOwCUsBsmRMicVMBXalXqS
	 c4t5skGPWH3aHuWVm2AAXJQ5b+VkZT2AyPnsrbZhPwHLaMh4dRe/5N9jXJVDaX8vEFE8f
	 O73c/xODUkw9AR/qlwB5lQVVGgnNWrA7YZ1sT1wzWg/MJ4DBJwKcWstsGc+vLjbWxieTV
	 TZxXIV5dN81KMlXXUA1WvAeVs8SIdJJyjdhqj7ohwHZLO47LqK1mT6Yilg9FN1S4G32Y+
	 2CXBRRhmJpOL+AvpZ6jEzkwN+YjVWkLP11fZe0isKW13gXVjgdgWyPCyvLfkVUbDoIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VAAtYU2R;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56325606A31B
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 07:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56325606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VAAtYU2R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793862887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cZkitsX+DewrI5AYsqUlHktt4nU0q8Qh/L8/eegqT0M=;
	b=VAAtYU2RgYH6pQzcks5y24LAZUYSV56hDWarr8l094ODjAnp8V1cuOURn6ywczROCOympa
	WveQ1JOJ8guwZ7ZDZMWMN0FKJCg4DOZ5Os5d85+LeIDPq9/IND3IAx3owZjauqdLiyj1m1
	bGpdYFf8bCLQ10xsqShdxjoYOqmGyMw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-lYXdGr1-Mg6AqjnILKP_aQ-1; Thu, 05 Nov 2026 02:14:45 -0500
X-MC-Unique: lYXdGr1-Mg6AqjnILKP_aQ-1
X-Mimecast-MFC-AGG-ID: lYXdGr1-Mg6AqjnILKP_aQ_1793862885
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4994d67d0e3so10311305e9.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 04 Nov 2026 23:14:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793862885; x=1794467685;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cZkitsX+DewrI5AYsqUlHktt4nU0q8Qh/L8/eegqT0M=;
        b=p8Zt17Wo3sTu6G587cmbakAKxwTfAS9DWJn8o7DUcU0GlTkptqMuzNnP7TY5nj0TSf
         BN+y4lPyUpN3UpP6pqteJtW//yCv3MBPeUY33GmOdyYRSUMXErzOLfNpzubBfK7M3JW5
         pUilxw33AdBtLzLJtNIqBf9kOkBDtzNeoDS8FjB0pIvZpic/WRgW0NkIT36KksYFeXnV
         Ob2X0LnTUlk6soZBnzkzOXoXpbFw7GOk+uM3cxBKCmHbo28DItfDGAuBOkyiPc2MBrGa
         Vv0k04q30ypDMaAuQpMFyGJjNwKrEWojfaMOsOxu1dXHYiEVrmenXjCznP666JBnYmwR
         KWrg==
X-Forwarded-Encrypted: i=1; AKwUvBwHnAAxoz/1AVnTP41+0KYQIm8MUDjnzbdM+ASBWiAFdsJKgBiw4LCHYTNzpk7pFCGB9N10DbIeQVUW94Flww==@lists.linux.dev
X-Gm-Message-State: APuU4Z97JSu+L20rLnaqvF0NNmZyjxeghKuD5nlItH+860PetsmV+MBG
	LgpXgehlK2OrJS82t8l00Fc2OWernfTyaqCDkSND6umc3dwtckV56IOxMj/a2cJ/argxz0P+9KA
	4N91tSX31HVfOpuHXJWjoXUBfbOJq5K6kICT0NpzBt6x7CNMiRy0uN1pH0FdnzHBVWuCn
X-Gm-Gg: AYBFou1hOghhYuhzA66/0gFBYBuVlMdp2keLxobhR/KpvxHczvlcl8RTKNBT9J1hDOt
	h5JWyuuIgjweTbITbrYml5AyHeXjVQ/OS6HHfOzoYeMjmDDKewsbqGyOn51pGmgB9pHi+N5iij1
	hSfpmfW4AnqdRlpjgRQx/zWbdeYlCT0W1aqtdqrF1MSqwmCI0QPFsa5mNWBNpRuqHiJLZ+wRZqG
	+oOEz7Bcu5vsxgIH3iUXlB+s+UMu10c8OTEYpdkoR1WTgNoJdBffp2mzImyDUbk6g+3POXu/oTr
	EkqWIJgfhxtFmsnMAAUqccsnxi0hF6KrGw8es9ahj2CbGS4mBsnRQFpViGf38s/23p3bGGdeM4u
	FxMPNlh+IHb810X6ylbSz0oLof5UInb0C1C4O2Yis79H1LcFtAN94gw+IvTgPvuCHEkIi8IhZNK
	axrA==
X-Received: by 2002:a05:600c:a012:b0:4a3:59c9:a747 with SMTP id 5b1f17b1804b1-4ac1793fb0fmr400160385e9.17.1793862884831;
        Wed, 04 Nov 2026 23:14:44 -0800 (PST)
X-Received: by 2002:a05:600c:a012:b0:4a3:59c9:a747 with SMTP id 5b1f17b1804b1-4ac1793fb0fmr400159945e9.17.1793862884464;
        Wed, 04 Nov 2026 23:14:44 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b572bba207sm39679165e9.10.2026.11.04.23.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 23:14:43 -0800 (PST)
Date: Thu, 5 Nov 2026 08:14:41 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Waiman Long <longman@redhat.com>,
	Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 01/21] sched: Reject SCHED_FLAG_KEEP_PARAMS before
 reserving deadline bandwidth
Message-ID: <auws4cpKvQnmNM4f@jlelli-thinkpadt14gen4.remote.csb>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-2-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261104211207.1392343-2-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: So-nVun6-OHQCHh1WoiXTb2X4Xm1cmsq_wZRRRQKns4_1793862885
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 04/11/26 16:11, Mathieu Desnoyers wrote:
> __sched_setscheduler() returns -EINVAL for a SCHED_FLAG_KEEP_PARAMS
> request that would change scheduling class, after sched_dl_overflow()
> has reserved the bandwidth of the request, and nothing gives it back.
> Switching a SCHED_OTHER task to SCHED_DEADLINE that way fails and leaks
> the runtime that sched_setattr() filled in from the task's slice, up to
> 100ms with a custom one, into the root domain's total_bw. Repeated, it
> makes the root domain refuse every deadline task, and refuse to offline
> its last CPU.
> 
> Reserve the bandwidth after that check, last of the checks. A refused
> request also leaves sched_reset_on_fork as it was again.
> 
> Fixes: 8a70415351ba ("sched: Reject SCHED_FLAG_KEEP_PARAMS when it would change scheduling class")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

Makes sense to me.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri


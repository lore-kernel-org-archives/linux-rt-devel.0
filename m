Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794479772;
	b=u+i7wuxmakr7EsIzYFGWruCgEqujPR2fvlYCDBLhyIAp4M9Bumf+kM0bPiOZXRPeKiWq
	 W0vfBWseDTanP0+XHmJ7X6t0gwW6A1dMytXI2CcHRuM1a8LPT3J9MfxzHE2/T7DK0VHqf
	 dgehOyIZZjuB+AcH0yEXxG10eJC2FYA1SNOVba3cETiV7t7BL0IRqeBSgzFFK5tfs1HbU
	 prMMuduWI/OumG7vzO9JRuJxjrvwCrU1vLSjMnO0T2ayMyT8dO82tAY0B47Cgqt15MGfI
	 iYoCmknwMtv48XVG0/CK4AqXZBcIXVwEqvHPq2/BcBtq8UqaGznY+JINANxw1a+Nrjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794479772;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=Ogwz7ul59oD/hj3UG/Yij9D+/c4RWMPymBINXQ6+9Bk=;
	b=q1M4E3EMBsc6NFyXPySrPcTMrTQGgR8AtS9L1WSYccOdYYN6piHKilz0ykgPHXuXtdzs
	 bL1pWB0IFtH+oDI3fPTaCJqqpd2RPkUCOJ9zEssCaRPzl/PRAd2a+nRYHk64AUf/Zs5Jh
	 0BC2c8O/k3hpLcrD2L+dlSqY8mD2n9SpPcSE+KGvov94U/KXMVHEgmUAGnuyxjeL3Rz8E
	 GSLjrQ+AoqO7AWd7wvej5euNyrtVqXpiN7HXsViXCUpE/27AvvPfYs0KwQZgdcZKxs11a
	 t/nFP/pTPRWTYfoORS+xso2YCbsw+9HXb9XsGVAVQ6xK8s6n1ARsuS2/EVg3aecDosg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U6OaBErl;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E12C606A881
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 10:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E12C606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U6OaBErl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794479771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ogwz7ul59oD/hj3UG/Yij9D+/c4RWMPymBINXQ6+9Bk=;
	b=U6OaBErlYMSHobbPrJAoJTPY3fslh246DBRqobmFAs8roRgp/0Fx6LTp0i9vQ+u0hwCsFa
	gPJzRGAI+QvuLXpM4wBPJILFXz9dI41hN1RCwuzCNf6fkRdxvlkoDzuTDI0jYVR377TB6j
	WYdrqMuFfCWqHWmOSmTqeZHgqz07OEM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-xs2jNypOMKGJ5tm5Ew1geQ-1; Thu, 12 Nov 2026 05:36:10 -0500
X-MC-Unique: xs2jNypOMKGJ5tm5Ew1geQ-1
X-Mimecast-MFC-AGG-ID: xs2jNypOMKGJ5tm5Ew1geQ_1794479769
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a70b42bab0so6022005e9.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 02:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794479769; x=1795084569;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ogwz7ul59oD/hj3UG/Yij9D+/c4RWMPymBINXQ6+9Bk=;
        b=1oJKKptcYouoobDaZ88f4ViVkdR7nXX6SKDbnzFc9W8ZuGq8heppeoCx6g0Ly53WmP
         21adlwHcdCefSp0cos7ZBy2/d4HbxSQFrHiqW7N8Siepgp2dDY2mYu29PvDr+uEBne2Y
         4TJn7OgSLSIaKfJfx8j0u1Kbw9AmZVjBoiLtOkqgyL0ptfEJamBUjiViNIep5yYSPuGt
         rME0UZUWvJUW6R+yTTytYB5W09l9LzciAF91FzrnmROU1nQfn5mFwcNHYt06zzDxTYQa
         Saf04XzXkbfp97nkfuANMo+ZyGmcqdes6SE75tZHHPfuUs9SVS73hyvNpiiG59+RSvkI
         EB7g==
X-Forwarded-Encrypted: i=1; AL+hErEhBgGncMGRs04HBE3DpVDp0ZoiRV6bweRtx7rVnN1UjHXXMQGFOxv/OmxeJCloI1ECHRrjODa3o9IdHY8M2w==@lists.linux.dev
X-Gm-Message-State: APuU4Z+IMTbC9qZ1uWcCv3/S7wH+wwp2P/8+CFv5Swk9j7N9WjXXWFRu
	NFADZ4UYrsO+DyuvZIRizxcvi+stCtIU/Cf/igFE5Hi9LN0U472o0OrrjQ7PcX0NaMioJ+bXAaU
	RqfTk39ner67lD1PY/FCTYqJ5u3R7pHfhbrSCRwhCZc4NybhXvyFaI55K3sgCdxR5OYQ+
X-Gm-Gg: AYBFou224Ggcf/YESKksOueZTbGKkYDX29LGCyQBTreQcjq9Yba39hjLjadfzUuzZ+0
	iddUc7AKHMc9MMPCAl+XCwLXnNVwOav60mEyp/6MMJCUu6fOl4nUA8+ywVHM1b6Ypy435IxMgiH
	G5FUuSQyUl5IAYQGIZtrvEbgwbIU5OZM5LeW7GZEQKavrtgq6OiUMLYlKfbbevCQ7E+3SJJSyXk
	3D3GFp2pvp4zeDhw+tatoq62Pwbk4ODvXGs0tX5AOxqM3+1z0hNBm/q/UA90u2PYn1WhxLQfWi/
	vodO93QaIyprHMV1jmJGlDTdO3l13bUmw0lW7nbA63Z+RVe/YhiZgKVMBgemLGS8go+MtnA6nGE
	WqW3jZ8dk8q7siCUPut6DczXLxf47brGD5n4XGfd/mMsXiitMF3NuAAnwEPxz7IWaPD/R+m4ZBL
	22K10=
X-Received: by 2002:a05:600c:8b57:b0:4ba:4395:560f with SMTP id 5b1f17b1804b1-4bb4e283efamr44875235e9.8.1794479768806;
        Thu, 12 Nov 2026 02:36:08 -0800 (PST)
X-Received: by 2002:a05:600c:8b57:b0:4ba:4395:560f with SMTP id 5b1f17b1804b1-4bb4e283efamr44874665e9.8.1794479768472;
        Thu, 12 Nov 2026 02:36:08 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e27a8b0sm60917155e9.15.2026.11.12.02.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:36:06 -0800 (PST)
Date: Thu, 12 Nov 2026 11:36:04 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, tglx@kernel.org, will@kernel.org,
	boqun@kernel.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
	kprateek.nayak@amd.com, luca.abeni@santannapisa.it,
	mathieu.poirier@linaro.org, longman@redhat.com,
	ridong.chen@linux.dev, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, shuah@kernel.org, bigeasy@linutronix.de,
	clrkwllms@kernel.org, parri.andrea@gmail.com,
	m.szyprowski@samsung.com, kayracizmeci@gmail.com,
	weihengqiuu@gmail.com, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v5 26/29] sched/debug: Show the deadline bandwidth of
 each runqueue
Message-ID: <avWWlEGGqVPYkuZw@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-27-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261108185406.1549770-27-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t37Ma9FR3Wjn7CMg08A205Y7ZB1Q8eaVOw6gBSXsCGk_1794479769
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 08/11/26 13:54, Mathieu Desnoyers wrote:
> For each CPU, sched_debug prints the deadline bandwidth of its root
> domain. It does not print the two sums of its runqueue. this_bw is the
> bandwidth of the deadline tasks assigned to the CPU. running_bw is the
> part of it that belongs to active tasks.
> 
> GRUB reclaiming depends on both sums. grub_reclaim() takes this_bw -
> running_bw as the inactive bandwidth of the CPU. The more inactive
> bandwidth, the slower a reclaiming task uses up its runtime.
> 
> The kernel warns when a sum wraps around, and when running_bw exceeds
> this_bw. Bandwidth left behind in this_bw triggers no warning.
> 
> Print both sums. The deadline_bw_test selftest added later in this
> series reads this_bw in its params_waking and random_mix cases. It
> checks that this_bw is back to its first value once their tasks are
> gone.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  kernel/sched/debug.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index e0d6cd3bd607..3dbe1d7d2d77 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -1174,6 +1174,8 @@ void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
>  	SEQ_printf(m, "  .%-30s: %lu\n", #x, (unsigned long)(dl_rq->x))
>  
>  	PU(dl_nr_running);
> +	PU(running_bw);
> +	PU(this_bw);

OK, but we will still not printing additional useful information like
extra_bw, etc. Not sure if you are aware of tools/sched/dl_bw_dump.py
drgn script; maybe that is already useful for the needed additional
debugging information?

Thanks,
Juri


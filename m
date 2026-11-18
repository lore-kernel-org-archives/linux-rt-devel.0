Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795000850;
	b=hW3V1ZA9MqNKbyebq8c5Mh2fJ9x11SEBqyetVtS4WDHKqJqcHRcZV4R5FjqNjKd8vLul
	 EmTNnB00nkuvY/p04J5FcET5HyGxrzv9fH7MxMi8JVNarSsuyzg/MBtTloqlPSsuNJpyL
	 hHzKJzTrwbyusweoJS0xRrNlzBUbSwz6akMb5sElhyI8n9kmRhEHuGinnf7pV6rkMUi2v
	 XNpecf+VLn1zobXQEY86Cs3UHGz8bzph3/leNu8rQ4HMlqGvGXn+iGpbymXAZvGm0YaRi
	 knJqYXLx2xk5e2Wet1GXh/al9YLZTYW9QbPwY6RTpUVW1hZBRm5ZfrEnXVsPNMX672Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795000850;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=UYZeLko8ARh+TMZJ/jcaVMaBZpqH4WAJB7a5zPUzakg=;
	b=1fgwV36/pT2KBAoY+Hfps+E6y17hKTSfTKMN6mRG9tVdMK1eI3r44StpAyMMl2obCZMe
	 sj6DeT+v7P6KWbtqOZ4TweRIGTP+cEwca6HL+J7+EwacpccnBskmKjRYCcoC11zJKEZNd
	 LUI0XHi1AOb6qKkACBYKoyM8I6+O/Sat6pHIr+NQEyQzUPct417txiTPPyZ1OIm0k9rix
	 Ll4u6mwkAfHlPtswjf7yqGfGPcjUcag5BMpWI+6nnEbRloEKlTPztvAaX9w2avIX5kWPC
	 d95NpfqegBqAdKlHOBpTS9GJPu/5wodq6gAP11R36/NTWupXdKMscJaAriZLAKm6DVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iORFFgFd;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4480E606A31C
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 11:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4480E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iORFFgFd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795000848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYZeLko8ARh+TMZJ/jcaVMaBZpqH4WAJB7a5zPUzakg=;
	b=iORFFgFd322gO9ZgYGy1IvDR74Gf36yEqNGJxd4+VfnSq0mZFQdnH9+yCpx8U86A6I9LPH
	JpHIUxeOoDT7gA1XSbyb7LQOPjXqz0u8A7H94AuXpi5sYcdLE1YWMFt8IGbXONS1johxXg
	eE2ofvemC7h+RRHZ5H5HchRrYgU04No=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-kDVpC1XoPtmwQ6mIH2yEEQ-1; Wed, 18 Nov 2026 06:20:47 -0500
X-MC-Unique: kDVpC1XoPtmwQ6mIH2yEEQ-1
X-Mimecast-MFC-AGG-ID: kDVpC1XoPtmwQ6mIH2yEEQ_1795000846
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4bb680f0ac4so5384775e9.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 03:20:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795000846; x=1795605646;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UYZeLko8ARh+TMZJ/jcaVMaBZpqH4WAJB7a5zPUzakg=;
        b=RlmnVokqcjTZoVA2oBx3mwmuDkEXoPyMIbweTOnn1isegAXrX7rQR100rHkxSXw7KH
         avjP7oYtVknRTNVRf4RfUCNp9eJGL2sTff8LNJNMzT/ES9sZJV23lQmNlFF4ZVMkd5So
         MmpHTOL/l9lLAfLUDLMmygNJuwPOdn8HWGF7iNMiloQE/ltlrhwTyO4rv20Ob7SkDz89
         bbtpDIlQMpZzGK/UyU1RPKqCJwAFjpkaE4ttRorOpOaAzXgAbUFh71gV3LzjeI5sTBPJ
         N078i8j4nwrrCxV4qOQTreaRQy0swxV168FAUvr3VCzoiUhZ1Ui7/ab9L5CyOk6EweJM
         qvdg==
X-Forwarded-Encrypted: i=1; AL+hErEIXQI1q1EyM8VeyD25LJHEstPiVOMZOzb4hePFTaN5briAkEsZM/aLbJJqD9oHfnn9QlVwyxwdGk1v+MGefg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Ni2p06TYwOPfQHQ0sNeebtIlqJNKqJ+W4Qo4577o/uG7/c5s7
	YUPd+W9KBPms25Ar0dSZOdyD1aAofNTZUUuUjl2NeWgRwVM/0S/8mugi6oFrk2bsFTynqIoqmny
	Im0/Xayr4PGuJtjllYppoB+ahXM5buMounsaihyhAHda5pOyI1HmB7VOvkbzQYpFB8fa8
X-Gm-Gg: AYBFou0zqlMjCEGN3DkGtJc2mmGIzm+eXgWBnD04mAGdwUqTcVJxT8UDGzzU61MOfMj
	0TJGnzpMyO05TKnc/Ar4RpXu5A7JCWOkawa7uzlOiLSwEP3FJVMYDZc9uFLDQ12HXSM03o7nlmu
	YUZ6LJcUnix2MscCRyXBkyJsQYQj0v4VEDPPlwxHCPwmYKKSIVSlj8j4SkWNzkQYcPRWtxSnUad
	qMc0TwLycPYkmlxGHALZ+8fPGr1yYgpw0wDSl4hGKXd0ZZs6Tq9UcmXTZUT9c2EvfaVCmbP2UQ7
	O4m0jcFJ+goYQD5mablrnxIU6Ic+tPe6/wADHJHUW5GhUn3E0H20U4Cu4QOskbz3tBp4GIc+NfF
	ipz3ZArVDRYfcGn0N+oO4DFDLEuJP1iNOV4H0wflzSXkpT0GG5Q++pGcetx+33bBcEwRlSs4+uQ
	o5hoA=
X-Received: by 2002:a05:600c:8b02:b0:4bb:6752:8400 with SMTP id 5b1f17b1804b1-4bb7da1b48dmr39551775e9.17.1795000845945;
        Wed, 18 Nov 2026 03:20:45 -0800 (PST)
X-Received: by 2002:a05:600c:8b02:b0:4bb:6752:8400 with SMTP id 5b1f17b1804b1-4bb7da1b48dmr39551335e9.17.1795000845561;
        Wed, 18 Nov 2026 03:20:45 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78418853sm195748985e9.8.2026.11.18.03.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 03:20:44 -0800 (PST)
Date: Wed, 18 Nov 2026 12:20:41 +0100
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
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v7 04/40] sched/deadline: Do not divide by zero active
 CPUs of a root domain
Message-ID: <av2KCeKAnXAi6saN@jlelli-thinkpadt14gen4.remote.csb>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <31f723a7dab4d58045cc60fac0fea09ea1841c7b.1794922146.git.mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <31f723a7dab4d58045cc60fac0fea09ea1841c7b.1794922146.git.mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dqQvIQGRdBX5XzNTvTX5X5GFsa3hVx8C5B0zIIZT5rY_1795000846
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 17/11/26 09:10, Mathieu Desnoyers wrote:
> __dl_sub() and __dl_add() divide by their cpus argument. Most callers
> pass dl_bw_cpus(), the number of active CPUs of a root domain. That
> number can be 0, and the division then traps.
> 
> Commit daec57983670 ("sched/deadline: Reclaim bandwidth not used by dl
> tasks") added extra_bw, the bandwidth that deadline tasks can reclaim
> on a runqueue. A change of a root domain's total_bw is spread over the
> extra_bw of its active CPUs.
> 
> During hotplug, a CPU sits in the default root domain, which can then
> have no active CPU. This lasts from the rebuild in
> sched_cpu_deactivate() to the offline, and from the online to
> sched_cpu_activate(). A debugfs write to the runtime or period of its
> fair or ext server divides there. A write of the current value passes
> admission in the window. In 8-CPU VMs of v7.4-rc2, a loop of such writes
> oopses at the first offline and online:
> 
>   Oops: divide error: 0000 [#1] SMP NOPTI
>   RIP: 0010:dl_server_apply_params+0x335/0x380
>   Call Trace:
>    sched_server_write_common.isra.0+0x1c0/0x260
>    full_proxy_write+0x58/0x90
>    vfs_write+0xcb/0x550
> 
> By reading, two other paths would divide by zero:
> - inactive_task_timer(), for a task that left SCHED_DEADLINE or died,
>   if its CPU went offline.
> - sched_setattr(SCHED_DEADLINE) on a task asleep on an offline CPU,
>   with admission control off.
> 
> Fix this by changing total_bw alone when the root domain has no active
> CPU.
> 
> With this patch, the reproducer survives 20 rounds with no warning.
> 
> Fixes: daec57983670 ("sched/deadline: Reclaim bandwidth not used by dl tasks")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: stable@vger.kernel.org
> ---

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri


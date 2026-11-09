Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228140;
	b=fvEIUqUkh5SaetG254SZ+Wh4QlNMS5HgIfCUS9hdApER1oo9BcByH9ZkK6ruxynmHOso
	 0i8VlIk01781H8aSQUcYQh3fwp+Wx9c3JNQJb8ToGM8jEu2zGZrPuXGFWaOj3jMztlOIJ
	 7EW6H8iZvAnqv/5BgIgCcJYoraOsSazoU1b/6r6l8Sq5tdteYNNJMY02uk076l24uoxl9
	 il6dDQGJ5YR44LwMLGiHPu2w7hml3fWAqV0mc7+EU0KoH2cJ1hPQ0xkMenM7DeGuvIMSV
	 SA/skrefLsPOcap9WjeGT/P6rJP+YqLovePaUfHBWdzre+RwbVpIK+PaLnz2L44JLDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228140;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=iydcdsyCbn/1HMCuIAo5cr9JeqRLn8CAd0o0w+T8bOU=;
	b=cwfDVYmW7JJBNmp1HeH5kDXFFor9tStoGWlbZhvp0b4tNA19ExPsqxERfmaCBnAkTkN6
	 yt/SvVkWRRXH3ygM0KGwEll9fTsJfVUFCafYhraOajpBbyN4FaYzxGZTuNf2m/kH5EVzR
	 AmoEXZRnHMbdBR5FSRA0cJJvue2nFjTT7W21Kk5o4yIhg+QE0EhlJNeiSeUMDeRJRY2yW
	 /Ku4mAf/JWjcHnwtd0aYo40a4r7uEEc+YGEu9RCDPjOmGvKZ6Ehwo5c95Qs9GaEWJsRdr
	 97Fipe/fdw7pYN5M7BoTYz9F005Pb9gO3y4Eq/OwfzLUUil0/gkE98oC5yvB8WKhjCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SCTbZtzC;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC231606A321
	for <linux-rt-devel@lists.linux.dev>; Mon,  9 Nov 2026 12:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC231606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SCTbZtzC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794228138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iydcdsyCbn/1HMCuIAo5cr9JeqRLn8CAd0o0w+T8bOU=;
	b=SCTbZtzCgH4lSPIUFIytRFcMYuiQAz/Rmb7MdGZlDEbOPqx+zpoK4p6C0e2rFoJP0xvC0F
	mzY3SX0rFpFOx3nywftco7L5vuT8wE948sphvbm4IThab+w1yyQFGDl6JznwgitpE5r/D6
	Gb6GXm3aGMBM3Snld+Xu6bNHe+YGj2E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-xmOwEkCFMf-FC7Kp5qdIhQ-1; Mon, 09 Nov 2026 07:42:17 -0500
X-MC-Unique: xmOwEkCFMf-FC7Kp5qdIhQ-1
X-Mimecast-MFC-AGG-ID: xmOwEkCFMf-FC7Kp5qdIhQ_1794228136
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a318cd95e8so7043635e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 09 Nov 2026 04:42:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794228136; x=1794832936;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iydcdsyCbn/1HMCuIAo5cr9JeqRLn8CAd0o0w+T8bOU=;
        b=C/RRNaDpkNAzPuRoEbDvvtbaH0h2dC42OjdoTkJhS9M6GV7AUvE94OsIl2ZDCrXaqY
         XV+j8Onx9zQ+8lvifUC+YoxOoTQ9uo2doWKWL3ewa+1H32o4AwYht2yy0RCB6E/IDsQ4
         QJBL3ErYiJyRvGQya61f24WcFBwsD6v6y7vob/K6ko2MbUAOVYfhhfn0A88gAiyuhUDY
         yFXAgSTcb9KFOl+DDZKumsZlem1eUFLt4Cs5JIux7wfD/VTSth014f0SH8B/Pm3MX8aS
         J4ZFutmAavrXUWsuUjUeH7gn4CB6/QFTE39kBucr7L3MxhR0i1nBZGLwzaax7YiXOJpk
         hkHw==
X-Forwarded-Encrypted: i=1; AL+hErGhtevpLWHlQaQpRzD5J4/tybJKdi0XNPiCYGstFzOchHPNiwJX63fkapnrC1jST96yGM7jBUyaRJXTnnR5zg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/gt4BsCtH6ma5ZMpoTXrf+knnalySpuleC6RFUKFdjUSSHJ23N
	07FzhHiRC1XTmT+gDklm1T3LNhmGJc2ThbSgJpZli5A66VR3aMiIfNI3KYU2SKR78LpjzmFcLNA
	2lbSoRj68qmfoEIo7cHn5f5fw6IofybV9tyAGnp2Sn1DrnLG4V9RTYGrg93soTvUWHE0Y
X-Gm-Gg: AYBFou0lR0Info0IZFbrjyYocu6dMRVXVsOdw8Gh3cyFnmrWZE9BhrrfxyQoVzo3ofM
	WBS1qaIpWrACajxhCv0ZYZK906gioYG51Ev5zjb6kljJ6QaYwZqmbUT5TBEGVYBKWbXxoHUOLCL
	p9PbjKKk0sYQVvb7D0OaX1LmafizIWfh4MRBRnbfOvp1Qhgh6LvAiULU5hbLwt1pzUoDzXKfkZF
	h7BhZCg7cgmuUWBiN5L6wSfrSPCdbBiKzDokVwJMx/sj/AE4DAw5sDI4Ooyf4+71yxjLsERg3B1
	A5Ar5f5AAxdraEJwQiS9HWRLQN0qLmoPSdQ6632lQUjScus8KEBhwb7J6oWAgNEyqdgMlXP5x7l
	ofB2JBe6/OIF0Vz4D/B+1IlqeAJbMG/WBe7Z2GeYcJfd88bW8BaJD3fN/21NWbsbJ1P1gu1MFIc
	/OUQ==
X-Received: by 2002:a05:600c:8506:b0:4a2:10f9:37db with SMTP id 5b1f17b1804b1-4b963c664fdmr75986285e9.7.1794228136218;
        Mon, 09 Nov 2026 04:42:16 -0800 (PST)
X-Received: by 2002:a05:600c:8506:b0:4a2:10f9:37db with SMTP id 5b1f17b1804b1-4b963c664fdmr75985755e9.7.1794228135838;
        Mon, 09 Nov 2026 04:42:15 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1f3acsm247331855e9.14.2026.11.09.04.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 04:42:14 -0800 (PST)
Date: Mon, 9 Nov 2026 13:42:12 +0100
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
Subject: Re: [PATCH v5 03/29] sched/deadline: Do not admit bandwidth for
 parameters that are kept
Message-ID: <avG_pJmgQr3V-PXZ@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-4-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261108185406.1549770-4-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: msZb8SxrszwmOotCalanxBhVnH-VjO4COlOWnkmh0Vo_1794228136
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> __sched_setscheduler() runs the deadline admission test on a request
> with SCHED_FLAG_KEEP_PARAMS. But the task keeps its parameters: the
> call skips __setscheduler_params().
> 
> Commit f4dddf90d58d ("sched: Skip priority checks with
> SCHED_FLAG_KEEP_PARAMS") made sys_sched_setattr() copy the task's own
> parameters into such a request. Then the priority checks pass.
> get_params() copies them without a lock.
> 
> Another call can change the task's parameters before
> __sched_setscheduler() takes the runqueue lock. The request is then
> stale, and dl_param_changed() takes it for a change. sched_dl_overflow()
> would put the stale bandwidth in place of the task's own in total_bw,
> and in this_bw for a sleeping task. But the task keeps its own dl_bw.
> Its release at the 0-lag time takes that dl_bw, and the difference
> stays behind.
> 
> Fix this by skipping sched_dl_overflow() for SCHED_FLAG_KEEP_PARAMS.
> There is nothing to admit for parameters that are kept.
> 
> Found by reading, after the Sashiko AI review of the first posting of
> this series raised the boosted case of the previous patch. Not
> reproduced: the parameter change must land inside that window.
> 
> Fixes: a509a7cd7974 ("sched/uclamp: Extend sched_setattr() to support utilization clamping")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

The change looks good to me.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

>  kernel/sched/syscalls.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 0e8b5c7324f6..894f93a80d5d 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -690,8 +690,13 @@ int __sched_setscheduler(struct task_struct *p,
>  	 * of a SCHED_DEADLINE task) we need to check if enough bandwidth
>  	 * is available. Keep this check last. If a later check failed,
>  	 * nothing would give back the bandwidth it reserves.
> +	 *
> +	 * With SCHED_FLAG_KEEP_PARAMS, the task keeps its parameters, so
> +	 * there is nothing to admit. The parameters in attr may also be
> +	 * stale: sys_sched_setattr() read them from the task without a lock.

However I had to wonder what usecase would still make sense for a
KEEP_PARAMS call on a SCHED_DEADLINE task, I would say a !DL params
change (UCLAMP for example) for a (at the moment) DEADLINE task that
might become !DEADLINE in the future? Maybe we could add this to the
comment.

Thanks,
Juri


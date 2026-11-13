Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585458;
	b=q7Wsn1I0esl9ovPLgyc12A8RiJHcdUESqfmfUWhIw//zCd55WB7psO7OrW+1fobvh3/W
	 RsAFNaP879mmMEKQJwXFhbMpJWDZifOrAkoJGRKy0OhmCTDnc+iMMzQNkakLIs5t/9pvu
	 z1N/AbFQj5mTyBXnLR6bW+qQZ+Q/+Y5k3Akl21z7IhEvnulxIO3gGvx/hE0FptYo7XnBM
	 flTv3TenY7CIGbBlJz7/5w4mK8pvjQi3ljjiAtBC8TWZetO9JeX5YStpuhGjxhAAa3Tkm
	 ZPv5EzlATjqWKnlCRtRpc91ohJs32p7H8qQlkIHmgzTlQ2/Ts/VWORvumDscINS5Sog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585458;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=OLPlzBmIGcwx65jSMq2uJ6Gd3E4PNgtasDmsnHDmw6c=;
	b=h9jO3KXELy4mD1M+OmDahZuVbn9f5hxUId3js5ZZWaHWI6ZOBb3RevMx0DAhZ+hdBj6i
	 a9gu8P4vr2+B+iLHMzsrJNbrIvM/+jeS4qoLRlmncXs4dyhuPZbnyFh0YkwVQEvYIDV90
	 ls7ItfOtXrwQUPZJunZaaF4acgMs5JZ73PF1llBqEgewvA3jyPNBpa6J4FD8+rgVnpiKG
	 ljjg8zXEsGiaK//501r2/3ttbfqcuIoIP5aZfAUANm2O4q48XaEZOoJ81N8X1zk71on/c
	 Neof4uh2P0gjPQanlsT5AvAWNgcoV0rSRIy8btkCQQwWP8+OtdMixjG3WoOLE1cDUPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IK4pYYxX;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E333460A6F50
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 15:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E333460A6F50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IK4pYYxX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794585456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OLPlzBmIGcwx65jSMq2uJ6Gd3E4PNgtasDmsnHDmw6c=;
	b=IK4pYYxXt5iE0hJfixngdZ4bVWvTW+7XXVnvoQHI5A3gploaeMLPFLPCgG8KVMC7vziQJF
	0z+AZ69ZyNNTkgz5wwomg2V4WZkAEApkJcCbFcQttMlTQ27G1LEerqpOyngijSTFfLcU7y
	JyyxubQqdS1EPhpr3yxJw7/T0dTAcLQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-DjfLKbDTMjyGmtSMpJDGRg-1; Fri, 13 Nov 2026 10:57:35 -0500
X-MC-Unique: DjfLKbDTMjyGmtSMpJDGRg-1
X-Mimecast-MFC-AGG-ID: DjfLKbDTMjyGmtSMpJDGRg_1794585454
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4931c89d228so691366f8f.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 07:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794585454; x=1795190254;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OLPlzBmIGcwx65jSMq2uJ6Gd3E4PNgtasDmsnHDmw6c=;
        b=GFSsjAGRzYNXfYq3LcfDHTpuXfviYyNgBkOnpLlPqrruv28uOwLpy0SuAPJao3GwR3
         1tCyCAcl/BVA8QfvaKcjGmuPkjXrFnQSHQLO1KZF2llFPUozNJ6olaEPfKjLCx1UaRZI
         P9uLDVUcr0BBMnSmkUi69BGDnjKjgKQTXDZdOhTTshTSyYe6ofPfARroXM4gmYCY1OWs
         802N3flC8YQaO49jLBF8HtWo4OM3JiFtiR/vtKXyXIjb9WQTV4DiSdUA7psWw9V0fMp8
         BelGSasSvkhzomAFDVaqLQZMqjdnOgr2OIpLHGYCGhG1/LNttbJKSX7YzCvy/xEb0LpR
         BKMA==
X-Forwarded-Encrypted: i=1; AL+hErF+FTAXcWtyzsdv1vfob8Brf6MvMbYXUbDMrtxtAa+5Ub7MRYBFLlsYO9vy0S2EFFgVaEJ6U3T3zlO80U4vVg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9cCC+Y29l/deP4aCYA+otT0mGSyVQiwPAuwXkoUDIdhvsyfiS+
	WZvIqv3RBK586cINEt5/zFOiuP2vyp8SIEoAaB9uNrfXE/OLoOd1UMQDpGfUB4r/gY2ZxlS7RzY
	juWiZ0tcP7Tzixj9SW+MrL0tIXFfgtflLBPodIXxajpFdFFgjCzJAr5vQmVj/KkKjo6wk
X-Gm-Gg: AYBFou2xkJ/mPzck/mNBE/7Rb7wQvCCswoxtZWr8NX36LETvL/NSQfK7sI01pABG0Ik
	jkAjXq/9MeM4bP+rJnK8UCgMx4sNNYEtaPqrlEu0b+4QqLU4on5JIeQ/K3Dmm13eiTppBxRYw91
	sM2Sr5SQdeBysSdk3aN0O9dUYp2x6K7zdGiRcqtJiWCrP7m8KdnAas1na3vw8rpocygu9rwWaJN
	Ji2RiZ9/IU6pwZw7fXPrfyloXd8h1UkDMX10UqswafJDgUL9BSlEHRJy6RVRw4cCEHBm1i3yaZt
	dE56jFDy1nBeYc0KS3ek5C9YeAjjqyLAvltehV0Bn94k9WiYlr0eqtXLRscRkzql/AMG8v0EmzD
	W0JmODD6vZk7V1pKupjYrUGef6l9r14JrjKSzc3I8wHkln6oCxG7qLhzEH2sesaL2TWFCdfZbk8
	jGWZ4=
X-Received: by 2002:a05:6000:2613:b0:48e:3085:7cf0 with SMTP id ffacd0b85a97d-49c7467b551mr5465779f8f.51.1794585454102;
        Fri, 13 Nov 2026 07:57:34 -0800 (PST)
X-Received: by 2002:a05:6000:2613:b0:48e:3085:7cf0 with SMTP id ffacd0b85a97d-49c7467b551mr5465726f8f.51.1794585453647;
        Fri, 13 Nov 2026 07:57:33 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c60116323sm5776550f8f.32.2026.11.13.07.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:57:32 -0800 (PST)
Date: Fri, 13 Nov 2026 16:57:29 +0100
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
Subject: Re: [PATCH v5 20/29] cgroup/cpuset: Give back the bandwidth an
 attach did not move
Message-ID: <avczaaXEh_xUhxpa@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-21-mathieu.desnoyers@efficios.com>
 <avWEta7b9X4K6hF7@jlelli-thinkpadt14gen4.remote.csb>
 <e21aaf40-b929-444c-b707-3200e21d7301@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <e21aaf40-b929-444c-b707-3200e21d7301@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cNZ4QUw_L0Y3GVS1oiP7nANyCfSyQuFn627IpVZKH6c_1794585454
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 13/11/26 08:12, Mathieu Desnoyers wrote:

...

> Three new patches keep a deadline task in the root domain that counts
> its bandwidth:
> - Where a CPU is picked for the task, a CPU of that root domain is
>   tried first. This covers a CPU offline, a mask change, a wakeup and
>   a rebuild.
> - A CPU offline fails with EBUSY if it takes the last CPU the task has
>   in that root domain.
> - A write to cpuset.cpus fails with EBUSY if it leaves the task no CPU
>   in that root domain. cpuset makes a partition root that would do the
>   same invalid.

Makes sense to me.

> The bandwidth of a task then goes to another root domain only by a
> cpuset attach, which asks for room.
> 
> With admission control off, nothing is refused, and patch 23 still
> moves the bandwidth. So an administrator gets past a refusal by writing
> -1 to sched_rt_runtime_us. The two refusals are new behaviour for
> user-space. I would like your opinion on them, and on whether that knob
> is enough or a dedicated one is wanted.

I believe we already have (maybe broken in-kernel) EBUSY on trying to
hotplug last cpu with bw standing?

About a potential dedicate knob, Sebastian is proposing it as well [1],
so maybe it's time we move to that. Need to sync with him I guess. :)

Thanks,
Juri

1 - https://lore.kernel.org/lkml/20261113-sched_dl-v3-5-a76ffa1cdeee@linutronix.de/


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407052;
	b=dIjJaq4hudkDvDveqrxcYImNWHusZn5limog84xmfrUUAMZErSHRId8o+Vpva52cEKqy
	 MSTD5MS9XFDU/ugfAS4SoQq43um/x9zvBQorHGjx6ESFaO3HFeFx4T3ecgOvrgHvKJYOE
	 0fywJCxtHkgykhJhvBe60i0u/IEyWyDtXDoZiAMqVI9a5usXQIYxsVApQ9RuV13+CU4se
	 m2TJsonITTrN7SbPRQVq73lvnyod5Zzrj2Gya4XGdTqFyPsqu0GeiQoKxwlH1Rl7VJmBB
	 l7jsDg7dbuQv337/DG7vJJqBo2R2btZ4MnNaX0eBBoFF+1+VuvJFy3Wll02+SX4Smzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407052;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=Npgvb84M0kJgdnmAsSFiguDvaupmEXtt/RUSJRF0Wy0=;
	b=xvHYWzTjSKvNuBooUokLms5/SzFKyf6VaiRr3ntE4sBdyL5ixeq+QL14IYUVIPOmetCl
	 cnh5elKoFQgUsixbvcwJVyrpFPFRk1J6G+HQpcP6pd3rT5Z7kLwOnuFIlp0bIgiKNsQiq
	 ++XM1RicptUOXeYzstxcz3VJ1KIcGHMX7kj8fC4CxWZC/ajzzmPY6Bwd1H8YIwGpN+uWt
	 +2xUXeQtEyyJPTljmvHy+pjriuViHrdA7N7Kw+24uR0obyLb5bg6VcqlOXHqE7G1jgVNw
	 zTOdNaBAPOqd32B1n7fU2cMFMMsQd9XX7LUdp9dUb1++a+EZMn3j8ajEmFjfP6NN5tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eVzWKmBG;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B72A606A33A
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Nov 2026 14:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B72A606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eVzWKmBG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794407051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Npgvb84M0kJgdnmAsSFiguDvaupmEXtt/RUSJRF0Wy0=;
	b=eVzWKmBGewX8fRDmN1htbG78LXSREfinw3WIfGRjv9KpxYzn9SOnbV+yz4gSfGotV/l3k5
	8J58EGnplioh0JYSDxUb6YtocE+xJjj4SQjTcZ71DiFTHzsX/fLIlfw/vDk7Dfz01IMaxQ
	q7s559663/DJ8L1aPfsAQZcvLrjrsh0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-2Kz73PRVOmS2cz3dPeQmxw-1; Wed, 11 Nov 2026 09:24:09 -0500
X-MC-Unique: 2Kz73PRVOmS2cz3dPeQmxw-1
X-Mimecast-MFC-AGG-ID: 2Kz73PRVOmS2cz3dPeQmxw_1794407048
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4ba078f26f4so11754805e9.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 11 Nov 2026 06:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794407048; x=1795011848;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Npgvb84M0kJgdnmAsSFiguDvaupmEXtt/RUSJRF0Wy0=;
        b=2qz3BJnNt8s8WUE+zzK8UbHQQG+sBc4hMP/GLPfpjFYa7NeYR4STvcoxrh93IgGoX1
         pyxVri9jG85PynrdGDfXmbqoQP8kJ/8OvV9FIVIBfxMXtEChDpPCe0OCtyvPhryyE22J
         I1VKvsg/uWceEjzPzGyEvm3ACmvh3MnPrti8YKCpDjfVpL+S8m3CYX6O0dP1RU5mVSYP
         fXzifw317hBid0BLOkDv6hB5ohL20aDdb17RDwhFuTT7/tX9endlXQfNr+I3+jGhZQzX
         ygaUt1Hc8CY6zRfGPBXOWDbJGQj9L8u8/ba3Xnr5jIiOqKyQI7D59A4xEI3wfyIs0zNR
         m7pQ==
X-Forwarded-Encrypted: i=1; AL+hErGdfjQ24D+ld9E8KjZUdrj9bndmOf+lcv4Jl/lZxXaRQPgGh7XRB27wQtHcgfysxCqK2LNhcxQO9cxRZMjWdw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9vRRlQdCOrCMPvIhl63brwyVOX0uwmmTaLXJnwTRONthUwpQ3M
	UMgLb0LHyJMHHJCWIugZqGttR5J2XDwmWG2ZzY3dyKdzfEobvLGyX/TqJedz69rpXkNvCipv0Op
	sdU1AifHdyvUarmHWnjv3X2gJiPe00HUaDJZlfTDNV0NqsabrJcxtMGMYYNEEOWW5sTe6
X-Gm-Gg: AYBFou0/CPYgDcnW+pLoA1TaQVFYuSh47rCfupMxYnjCZM/D3wYBPdHRc91JwjjuKbG
	o3oyU14rI138AE/ayUHIiuJKCxd7xFytOEuBR4BFw8Wi/a9G2Hq6CZ5jzicJoNRh3SrQIWE3r9p
	t4kLxvZRA224rc7yDN4WbM3D3B4y1ylO13N7sLofPiOECFwuxGLlS3ValfKllNc41cmHpYD/+1V
	s8tgJTD9K2RgV8L2UlEa5oy/Uov0LvAOEZv+MvP6SBm3W0ve29CnU/RGbUfr330GPKAIk5Zo1aq
	QoiR/aEBPt4vPRVVA19/T40T1P14eu2orH6Z5d/FQ65NQeq403wsMkmsIFqj+86seoqfynD4zOv
	meeEYpxtF8Sy1XwIE139XDjf9nwEbHZZyBExihhKBRZt00YgXng1lB7mHRFZDya8xW6+PDxCEPS
	JHVa4=
X-Received: by 2002:a05:600c:840c:b0:4af:c210:5b3f with SMTP id 5b1f17b1804b1-4ba09377dbfmr46939885e9.24.1794407048243;
        Wed, 11 Nov 2026 06:24:08 -0800 (PST)
X-Received: by 2002:a05:600c:840c:b0:4af:c210:5b3f with SMTP id 5b1f17b1804b1-4ba09377dbfmr46938695e9.24.1794407047403;
        Wed, 11 Nov 2026 06:24:07 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585c5c4sm9579508f8f.17.2026.11.11.06.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:24:06 -0800 (PST)
Date: Wed, 11 Nov 2026 15:24:03 +0100
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
	stable@vger.kernel.org, Qais Yousef <qyousef@google.com>
Subject: Re: [PATCH v5 15/29] sched/deadline: Rebuild the root domains'
 accounting from the task list
Message-ID: <avR6g-ndjl8Xdo1y@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-16-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261108185406.1549770-16-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OFBuGwzQeENGS-ZY3FRVQd_7BO7qDv0cyRS_tdUdJH8_1794407048
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> A rebuild of the root domains, as on CPU hotplug, clears their deadline
> accounting. dl_rebuild_rd_accounting() then adds back the deadline tasks
> of each cpuset. Without CONFIG_CPUSETS, it is a stub. So the first
> hotplug drops every deadline task's bandwidth, and their releases wrap
> total_bw around. In testing, a root domain admitted 9 tasks of 10ms
> every 100ms before a hotplug with deadline sleepers, and none after.
> 
> With cpusets, the rebuild skips a cpuset whose nr_deadline_tasks is 0.
> This count spares suspend and resume a costly walk of all tasks. An
> attach moves it by a tally taken in cpuset_can_attach(). A task that
> leaves the class between the tally and the move is taken off the old
> cpuset twice. Its count can then reach 0 with a deadline task in it.
> Every rebuild would then drop that task's bandwidth.
> 
> Fix both by walking the task list, with or without cpusets. The walk
> finds every deadline task, so the count and its hooks go. It holds
> tasklist_lock for reading, so fork and exit wait meanwhile. It locks
> only deadline tasks, where the walk that the count avoided took the
> pi_lock of every task. It leaves out an exited task with a dl_bw of 0.
> It also leaves out a zombie whose bandwidth an earlier rebuild dropped,
> as dl_clear_root_domains() does.
> 
> Without cpusets, a new dl_accounting_mutex keeps admissions out of a
> rebuild, as cpuset_mutex does with them.
> 
> Three hotplug cases of deadline_bw_test, added later in this series,
> fail without cpusets. With this patch, its five hotplug cases pass, in 4
> VMs. Its death_zombie_hotplug case tests the zombie. The Sashiko AI
> reviews of v3, and of v4 before posting, found the drift and the exited
> tasks. Its review of v4 found the zombie.
> 
> Fixes: f9a25f776d78 ("cpusets: Rebuild root domain deadline accounting information")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

As you most probably know, the count this removes was added because Qais
reported 10-20ms suspend/resume regressions from the old walk on
Android, and the merged fix was validated only as "delay no longer
noticeable" on zero-DL systems. Added him in Cc.

The new walk drops the per-task pi_lock that dominated the old cost, so
the approach might be OK, but since this is Cc: stable and will
eventually reach Android, maybe someone from there can confirm before we
pull the trigger?

Alternatively, a single global "any deadline task exist" bail would keep
suspend/resume free for the no-DL case without reintroducing any
per-cpuset bookkeeping to drift?

Thanks,
Juri


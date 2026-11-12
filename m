Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794469823;
	b=SZCR3ugeOFTZSJhnfPp6XKz2PDaZzlbqkwstjubnOgkcBq6orVqcMQsF7bjPfABsvSxy
	 tv4uZh7ljFkQ15oaws3pqfHWPkoiwHI02+9FMbVHI+ct+YXNtfaj3EGppocu6lDYp41ic
	 uyg28qajG9eSXYWg+Abkd5gYC2PPJhrCLqsbfSewNyHVYi8q42cmuYlB2mbREB8H3mTJc
	 P0q3GAClO1sKDCEitT1NCmMsprGNN90mgIfMMEPA+7SbErjCCsWofZ2BsNEXpc2+tFgEy
	 GPjVRBeMHne/kJZ24L4kRJYpwWt9lKCgfJdjKL73T9HoINpg6+Fr0YqsmYlVnw/9H9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469823;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=eAEaXknwutXsE98av80d8xzVhjo04EdbVXbDbQO9bFo=;
	b=b9oDjpdxisxL68m3LqMcX04+rcavm1kpR9eYsE8269dERPxTWtPabqjftWiOuV1tiqQG
	 gd4bSK7rrLnIJcPd1v+EskDbDehgmY52xrPyX+KpaTpBEsU1WECF18WHCWY00kt2YXW5/
	 1K0upIvg6LuM6F/QjW4BBDfe38NNWNmuP8Duh9MaSF+1YQ5EYwTkx8GA01Ee4cI7aqtfV
	 2SNygxNrt5ZmBGK1UtFqdF+xKReJ3NA1BWsY0UVKqQjQLjlGNqcXEBgnu7kAPvUHtT+Vn
	 Jk5erEbqEgeYAMJvZBzUUSl1P1UfIU290n1g8ei3012siunt5vorhxFPxdl93dhGVBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xv713XQN;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12AC606A32E
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 07:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F12AC606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xv713XQN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794469821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eAEaXknwutXsE98av80d8xzVhjo04EdbVXbDbQO9bFo=;
	b=Xv713XQNnukDy4KF56K5FPRGBnkqINumW/dN/5usdoipW2o4762byiHWqDbPSl2Sx8thCl
	N0npeaGvJFUmRm1lAiS1AUP4nxTRj3UGJ/lcIFCLW/05VHjWIY2LoZ3WlK99QVR0Yy3B0J
	AMCoV28FtuBqMFS4s2jh2we2M9OCiG8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-oz_iA1EPN72-OpN-VnyyYA-1; Thu, 12 Nov 2026 02:50:20 -0500
X-MC-Unique: oz_iA1EPN72-OpN-VnyyYA-1
X-Mimecast-MFC-AGG-ID: oz_iA1EPN72-OpN-VnyyYA_1794469819
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a35e1d2dddso32235935e9.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 11 Nov 2026 23:50:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794469819; x=1795074619;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eAEaXknwutXsE98av80d8xzVhjo04EdbVXbDbQO9bFo=;
        b=XPiR8M/XV8enz3P470iQw0egXho7fxay9bEOJEQYP190Erf2Q6CQMB3Co5IM2Sm2vs
         6VezMitpbm8lewgRzARDMtMOLMAClBlPhSbf1Nl8QRidkwVfCeGqnGvAUJlPV6MX5rsk
         FrFbCzavClmOsaLy4yjsWvZHMd/748ieT292Jb7wsa+a+FyDNNGD+eXgvlWiEo4b6i6c
         +QfxAUPKikoArfynijvZuJyc0c6qlWXyq0i2dzMXi47pDlDxOSI1qHP5MLAbdjY2YS66
         6vvaji8n+B5IehbQBuTQUTVNqR8r+gu5hiGnPS8D8XxYisXWrUXFtq3yC1KKvKMkPOau
         UECA==
X-Forwarded-Encrypted: i=1; AL+hErHQ69ER72hXSrgQcjskoup/sOE61OpHpF3kUpdk+e2eband/CH13TRptlwLUnGEStb5hMu+Y69DMEc9xMHBeQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+sRCUL88i1OhYlU1XdKJmbZANzwkA2cjwAzDd2OTSqjKvXwuf0
	x73Nd6HFue6Iqs3Qvz+I+II+wgPewaRMku1wjmcuHATnseZkOym7IU1u2FDd+AIXuxOSVPAPu2f
	rWvAEccfReM3i+a+iysfRSCHEmO4Nn8HYzPnH6iWvwj4wV4XVxsREx5EE2ZvQ5RIgAq98
X-Gm-Gg: AYBFou14G1C9lLHkD07ewKDS4NKk+z3Qi77BQ3Lf2Os8B0d8mfqlZkl27AH4zrGA+hg
	skPgzgqJspzROKRXAYc/xArJTsb8sCVYT/AwaTGpFfx772tlvXSq+xwzkuZzC+EpnTjritwRom1
	he7bYWeJGX6Pp/AiasgndSd6KkGkF+APL4Ew3Mvr3TQXkCHUxBt7lX4eRBjm8KY6lDuh85EA+vc
	s4WWCsjZ+aJmNTIJ+hwUrsvN8H6L6OvH9yEwZUYFRSb6M77EUyEkXQTupZphDj65XhTvpFLSQFz
	Anyn3AJvCcy2Svaikr1jgDyRccb1RmjA1ahBd2uyvvu0CdJxV7fuObukXtTKq+x7e1RWrMrgBz6
	8afLe2xMyo2K2MRBCTQl3Y3zJyxt8P+rc7mX3LnAGrlJRMmpem/BSiWPPmi5T/4rS4zn6hk9JuB
	p3WqQ=
X-Received: by 2002:a05:600c:1986:b0:4a1:f7f4:7cf1 with SMTP id 5b1f17b1804b1-4ba09376d2dmr82685345e9.11.1794469819068;
        Wed, 11 Nov 2026 23:50:19 -0800 (PST)
X-Received: by 2002:a05:600c:1986:b0:4a1:f7f4:7cf1 with SMTP id 5b1f17b1804b1-4ba09376d2dmr82684805e9.11.1794469818478;
        Wed, 11 Nov 2026 23:50:18 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e28c882sm52359655e9.6.2026.11.11.23.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 23:50:17 -0800 (PST)
Date: Thu, 12 Nov 2026 08:50:15 +0100
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
Subject: Re: [PATCH v5 19/29] cgroup/cpuset: Wait for an attach before
 rebuilding the sched domains
Message-ID: <avVvt8wlKqW4LqTa@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-20-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261108185406.1549770-20-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UUWU_AH0gAp2d9IAu4rhVmNiXTsNm4vavE2FNDFxnow_1794469819
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 08/11/26 13:53, Mathieu Desnoyers wrote:
> cpuset_can_attach() reserves the bandwidth of the deadline tasks it
> moves in the destination root domain. cpuset_attach() moves their
> bandwidth later, on the strength of that reservation.
> 
> Commit 75f7a25ec6bb ("cgroup/cpuset: Prevent race between task attach
> and cpuset state change") lets cpuset_attach() rely on what
> cpuset_can_attach() set up. The writes of cpus, mems and cpus.partition
> wait for an attach in progress, in wait_attach_done_lock(). CPU hotplug
> cannot run in between either: it takes cpus_write_lock, and the attach
> holds cpus_read_lock throughout.
> 
> But a rebuild of the sched domains does not wait. A write of
> sched_rt_runtime_us and the energy model rebuild them through
> rebuild_sched_domains(). The cgroup v1 writes of sched_load_balance and
> sched_relax_domain_level, and hk_sd_workfn(), use cpuset_full_lock().
> 
> In this example, a rebuild drops the reservation. T is a deadline task
> asleep in root domain R. Thread A moves T to a partition root P, which
> has a root domain of its own. Thread B writes sched_rt_runtime_us:
> 
>   A                                      B
> 
>   cpuset_can_attach()
>     takes cpuset_mutex
>     cpuset_reserve_dl_bw()
>       P's total_bw += T's bandwidth
>     drops cpuset_mutex
>                                          rebuild_sched_domains()
>                                            takes cpuset_mutex
>                                            dl_rebuild_rd_accounting()
>                                              clears R's and P's total_bw
>                                              counts T in R (not moved yet)
>                                            drops cpuset_mutex
>   cpuset_attach()
>     takes cpuset_mutex
>     cpuset_attach_task(T)
>       set_cpus_allowed_dl(T)
>         R's total_bw -= T's bandwidth
>         records a CPU of P
> 
> P now lacks the bandwidth of T, and admits deadline tasks beyond its
> capacity. When T leaves P, P's total_bw underflows. In testing, the
> race left a destination admitting 3 tasks of 10% too many, or P
> admitting no task at all.
> 
> Fix this by waiting for an attach in progress in
> rebuild_sched_domains_cpuslocked() and in cpuset_full_lock(). The
> latter then takes its locks in the order of the writes of cpus and
> cpus.partition. A rebuild from CPU hotplug finds no attach in progress.
> The online, offline and kill of a cpuset never wait: they hold
> cgroup_mutex, which the attach holds throughout.
> 
> The move_vs_rebuild case of deadline_bw_test, added later in this
> series, tests this race. Without this patch, it fails in 5 of 8 VMs with
> 8 CPUs. With it, the case passes in 8 of 8. The next patch needs this
> wait too: without it, it would give back a reservation that a rebuild
> dropped already.
> 
> Found by the Sashiko AI reviews of v2 (the race) and v3 (the cgroup v1
> writes) of this series.
> 
> Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

This looks good to me.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

BTW, this and other patches are actually cgroup/cpuset domain, so we
will need to ping Tejun, Waiman and others at some point (if they are
not looking at this already :).

Thanks,
Juri


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874010;
	b=Fm9CCo8kmErofwYO/xjKaxKSz12gYSxu4fyGzUMlZ1x1saDOm7ugxa7afqP/lbjW4t12
	 nZQ38jCnHC1QQv+O1NKRQzQYiCHHSAKOzfPHUvIClVO3dmQ+0YZ2S+rcYq/KnlfDzAnw6
	 dWxaKkD1w6C4UuSl5li4uwDMABFzB4jm1B9cxceG9Pfn41x/tIXUpCKdvVkSK5aSxrui1
	 Xg2DHXnr6JSqsPPvAu5P1u6xZonCJswqva03zVW63o9Dq1tjGJlyNxlyF286jp8D4M6aK
	 33ewV33kzQ6KnXOfXztchdN6EGjqBjGjGcJYTrg3etQuELVgp2ohlNw4tM8rJ8WojJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874010;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=jIr+BXQHSHpw8ds71xVo6cb1zGmQevyMjrEckDJRick=;
	b=DpmUzLgh8pwAQ24zouuK6Ls2RAeVQF96DCd1MYhLlCwMhCRIXh4Bxm9VEWwarNAxsHxM
	 +PK1AqeuH4i1LhHByq/azUoTtxb2ExWZL6w2O2qPj0+96mBEnBt/c8aROCs2nj3kZBLQN
	 zdExb3AHZoxAEZTep7E9Gs0TTKYy0QK8bQzjdIRn6VvvBFLzCPeV+RmJCir3FN/dJ68G+
	 LhrvhKvtoPKdmBhgubDtRW6sUsx38os41C2QLiw2oT089+8k+mloggy3roNX71ZTAKwdr
	 4WWP0FXPwnsA2cwCCfd+++4NtHCV+D7WW3C3p9dvf9hfrGZfXTn8L+EuUx1DlMWmrXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ma9Ji7BY;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34D6606D832
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 10:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E34D6606D832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ma9Ji7BY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793874009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jIr+BXQHSHpw8ds71xVo6cb1zGmQevyMjrEckDJRick=;
	b=Ma9Ji7BYDDH3SN6c1h3ZLorHgaPTel0T+5ebwrlUP/U1PSzSmnhYm9Ew3iKW5a2E++9CFR
	aqLXvwbzR8DmwmhSP7rUzs2iyJC965iCDVcXNYBJNe01R/alZySWSTyYyc57dYf4tS/49t
	Gi1p/wLaBNQFCRJNY/b3oJiRoU0T8QI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-n8PGkDJmP2ObyLto2b3izg-1; Thu, 05 Nov 2026 05:20:05 -0500
X-MC-Unique: n8PGkDJmP2ObyLto2b3izg-1
X-Mimecast-MFC-AGG-ID: n8PGkDJmP2ObyLto2b3izg_1793874004
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48c6a1d4034so1482673f8f.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 02:20:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793874004; x=1794478804;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jIr+BXQHSHpw8ds71xVo6cb1zGmQevyMjrEckDJRick=;
        b=UyS6OrxZmXIFo+t6D1T3r2Q/IIGBrhYX38B0ogMqC66+fB/0Fe5xPgr81mWy0+ixt4
         R3FhydVcSKO355OBWp+Zr5dipRXy2GGSXskCIwK4lVOW0SU0LK6hjODLhmy4pUMdZ6We
         7kXoKQt8ijI8V+4sUAQWCvDzOp9cIm2YyTteuhX1oYPyOhJucSeIx5I//gKUKug9J2ga
         OTo/GzSncrOqSLID9jzzlg3Z5fYjTSyh+nhjX3OddRAH0myZshMzRsEUlP/O9HJV1xiM
         yG3FUJLnQiV/fdZYNpi1jWIfor2THP+jme+7tNfIlRrWJOYI7H4qqV3elNb+Q7CznnTa
         f9sA==
X-Forwarded-Encrypted: i=1; AKwUvByWazIDhB2q4sjyxQf3/K573rxYWF+x3zURiNgoA98okr9/1pN/stqAsyv6xiCWusHLbJaFEAMk6Sep6gGovg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+T2g21Tl0Dn5bpYpMTyUWBG4PgAaVojT//21MWF1d7ztdyeUoB
	fbVgGW/UtfO7Gszj9PleN/N+bLJAa9IdSGw5gyhuWUjQbkoni1aRe4aAUfOLJsxZUw0x7wTdZwP
	Mi5/igGiUE9C/kTq8YonT1G/soorRoMDez2UKirzBL/pAwZRLjpNUhJU0k478X4TSUGyl
X-Gm-Gg: AYBFou1T448JTDxreyGMpfPIGPtts2qAuSZodVAaCzVsb8nA3KWMTcxciNLTm9/6/4B
	ISziMf6u4eG2mpiTQ8tGSrVe03UfQy8Dd9iB5zD9B+vB5IqN4T/oaVca7g6CxByCeCyJyL/b4ub
	NPPI3//rJDdsKFGitb/7poLpo5gCdDM3woU0CZr8EJLsICd3oKpJ8lZRPh2N3ulLk7T1TeZEVd9
	RokNet0n+D9hcDU479AK+usqt/CWOvLf+jGfLKNfZRtvFzB9kt09B4z4SS3h7urLcJywnl44eLw
	Ucn0liK3rtu5HybC2Jbh2BovGXH9hj4I9XdRDuRa1kgPGAWZTmED7J+hz3+FGRxk4LyZUcQf5Q/
	kYIqbw1W5bMgPxN9ITiY9KPsHGZpkQE+bZA7i8kFj3LF7YXxl/vD+Hlv1dHnb8y2jCWMBGOVFL8
	07Ig==
X-Received: by 2002:a05:6000:4027:b0:48d:fbdd:4132 with SMTP id ffacd0b85a97d-48e6e4f540bmr39671577f8f.18.1793874004480;
        Thu, 05 Nov 2026 02:20:04 -0800 (PST)
X-Received: by 2002:a05:6000:4027:b0:48d:fbdd:4132 with SMTP id ffacd0b85a97d-48e6e4f540bmr39671524f8f.18.1793874004043;
        Thu, 05 Nov 2026 02:20:04 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea180ee1sm10646770f8f.4.2026.11.05.02.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:20:03 -0800 (PST)
Date: Thu, 5 Nov 2026 11:20:01 +0100
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
Subject: Re: [PATCH v2 03/21] sched/deadline: Do not admit bandwidth for
 parameters that are kept
Message-ID: <auxYUb0-GSpZjhd5@jlelli-thinkpadt14gen4.remote.csb>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-4-mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261104211207.1392343-4-mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RKD1_UFDPfrZD5xv0P8p716AcSOAkSuJ8vMYeVMQ81s_1793874004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 04/11/26 16:11, Mathieu Desnoyers wrote:
> sys_sched_setattr() fills a SCHED_FLAG_KEEP_PARAMS request in from the
> task itself (get_params()), with no lock held, and
> __sched_setscheduler() then skips __setscheduler_params(): the task
> keeps the parameters it has, and its dl_bw with them.
> sched_dl_overflow() runs all the same.
> 
> A parameter change of the task's own that lands in between leaves the
> request stale, and dl_param_changed() takes it for a change: total_bw of
> the root domain, and this_bw and running_bw of its runqueue through
> dl_change_utilization(), then hold a bandwidth the task does not have,
> and the release at its 0-lag time, which takes the task's own dl_bw,
> leaves the difference behind.
> 
> There is nothing to admit for parameters that are kept: skip the check.
> 
> Found by reading, after the Sashiko AI review of the first posting of
> this series raised the case the previous patch refuses. Not reproduced:
> it needs a parameter change of a deadline task to land inside the window
> of a SCHED_FLAG_KEEP_PARAMS request on the same task.
> 
> Fixes: a509a7cd7974 ("sched/uclamp: Extend sched_setattr() to support utilization clamping")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Thanks,
Juri


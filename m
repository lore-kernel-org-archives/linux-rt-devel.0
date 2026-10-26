Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793001951;
	b=k42sOTCmccX/TseFoZIU4E2Zqy0x6YPPQXX8lU2E5EwEzZrgHuSAWsYm5Xjwp8ESi1Pc
	 vunztJR3Gp605J9BItMnymjHRGTaqi87L9k7/v6Luf/9D3IKKNQnDs7pwCQzY0KfydDMi
	 WlRcniCKH4Hm5LKJgjTffT4QL4xvShfZ+f7fFvdAS3rSLfagqUw9KOY056tTF6OcN/4Ho
	 oGOGFf+R38he0K88HIlT0l+5V6YMAYVxjnlzdD14/ENm4QDLR2ECZomadaD93GZco7Yuf
	 dD8RhbU4HhOUGS9jlO6/7YS2wf7zmyMv3kJehunvRQMqM+zKLcB8GngoJs8PKYD4UkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793001951;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:In-Reply-To:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=D242ShT8h8RdqZ5L8WmZvCimBf9zTP6sn6+Cdrpwgt0=;
	b=c8KJV2Ww/sh8y7iQnagjyHWM3jCWwNSI53Lmp0Q6W/iBFH6OqLZ5Gca6OW6zsh071pLM
	 kG/acuxhWOry6VNvW9YB12IUWCLSiO2pVuTpBmat7v9IvQY5cIyrh1Lo2QDGLS0cTbIkH
	 UfAY3h8Vtazg9+llwhneu3jxj6mDe9LeqV67tdLqRgMxm7EK54DIP77aEa0sRDdc5EZMU
	 f2mj4ZxwB8SIDXJtwz5w+eNV1uVBDFI4P0qIzG/7UmxISgC8h8nc9wbsjVwsA++wlorWj
	 lxaicfXlcqWFtV/x2+xrg08YCMrkBMpbCQQB7o7PCi3GGvWgKxt3NG2qBr+9yKUTuZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cM5ExTEn;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75151606A322
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 Oct 2026 08:05:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75151606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cM5ExTEn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793001950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D242ShT8h8RdqZ5L8WmZvCimBf9zTP6sn6+Cdrpwgt0=;
	b=cM5ExTEnpyMtMqK1RTTYH4l0UBXUfEgtlegi5oIpLFVynDMyfI7Juq12CZIExtslARfKOe
	/SaOKJO3C2vxBGpEYy4wbNhdr52u9QiwerdbuoJRhrkx4YmPqUyqP2KkB12u0bjd76512A
	b26BNNW/nuCQXR11TH1ag7kDe/QuWpI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-UohhgNeXNCyKXxmJ3UsBDQ-1; Mon, 26 Oct 2026 04:05:47 -0400
X-MC-Unique: UohhgNeXNCyKXxmJ3UsBDQ-1
X-Mimecast-MFC-AGG-ID: UohhgNeXNCyKXxmJ3UsBDQ_1793001946
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a204f135ffso16069355e9.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 26 Oct 2026 01:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793001946; x=1793606746;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=D242ShT8h8RdqZ5L8WmZvCimBf9zTP6sn6+Cdrpwgt0=;
        b=ffdNXz4doG4iKUR0jGYfdLl+CvL2H+btAnCNx0f6fG3fCcRtMYEILP1FdJBjU8XY7X
         M5HyfLDX5SFOOX7pHCsd6uH6GtV9sAlM8a+murVpWOnXm5WoAuMPAikmadaKyI5oBDSq
         RWDuX6qAzLRNFg7gzF3K0W+pKi6Qx/iaE1+okh1N3pSvhlEPB+r0R0d/tY/KOoDW+/7r
         46USsBKJDFKRul1J9zRv0Ad6lLHBB82jnu9RKI1R+I2esEFb1FoYYpQ/qhbHhFXqMKzH
         ZTkSOVxWneVWajpdM/C/V2tp+QIz/I6eyDwdZwDKryuVTGeU4AWW6bCHDckNu1kN3uUI
         tVeA==
X-Gm-Message-State: AFq9FYL2zJzAtFSTEVTaicP1bS3Mk+mv95FOSroG2N4kjkUi0NAeX22t
	A/FMNymtISOY/wAK1MsZHs35nKf36BSK9/JHsA6xTv+vcpeEnATZRRdkA7dqxLuoTaCVGQFlHEl
	CXbX7I1U0lub4dsQez+WcfisFp6brWy86+ny/hvEJgk4PDHgiyFzDwoX/R4J2v9bfDmFLOckQTm
	bUC80=
X-Gm-Gg: AYBFou3vE6TQ+N/JjoDioatHGP3rgxdjt+dwoSiIisxWm41AAsUEMmdL/wCleo+vkL7
	fCDN/Ijg1VeXxwSaN+/Y7u8OFmcO+/BT9slHnT4dG5eg/PShE+iDo63HSpuJCFvYXorLdipvBis
	a3GQ57GDWeos5pqnpKTR+Eq0dUcxoDEsmEp2x5fzben7iO6rpL2XLwPhMfKw28c3jkH57/MeI+c
	QSmP2KKf1gDeu27sUBAREePj2d1jk1kzYy9UMlaJs0CyzUJlalK3yMI44OaaZbVIX1auB4iN5iC
	xOvOMeM/jupILzkRrskxA7WBrDHcycGmkTBtn5cW2D89fZdJMJk5UGahP0ReAWFhToK2+8sIeZd
	AoaGNIXmYMoIX6QE1QeO7Q9jjVx/Fny8=
X-Received: by 2002:a05:600c:190b:b0:4a5:cfc:1e95 with SMTP id 5b1f17b1804b1-4a50d0b6418mr72057925e9.33.1793001945631;
        Mon, 26 Oct 2026 01:05:45 -0700 (PDT)
X-Received: by 2002:a05:600c:190b:b0:4a5:cfc:1e95 with SMTP id 5b1f17b1804b1-4a50d0b6418mr72057595e9.33.1793001945189;
        Mon, 26 Oct 2026 01:05:45 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([176.206.35.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3cfasm14911211f8f.17.2026.10.26.01.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 01:05:44 -0700 (PDT)
Date: Mon, 26 Oct 2026 09:05:42 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Shrikanth Hegde <sshegde@linux.ibm.com>
Subject: Re: [RFC] RT throttling, DL/ fair server, RT_GROUP_SCHED and
 everything
Message-ID: <at8J1mimeQ2oPZDE@jlelli-thinkpadt14gen4.remote.csb>
References: <20261023161348.t3lpPLQZ@linutronix.de>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261023161348.t3lpPLQZ@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hsD9w1gJ39sl26KqHwGGLjjEtjxZXQnugaZoDnzi_AI_1793001946
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Sebastian,

On 23/10/26 18:13, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> this is about the old RT throttling mechanism, the DL/fair server around
> the RT tasks, the /proc/sys/kernel/sched_rt_* mechanism to control the
> former and CONFIG_RT_GROUP_SCHED which never worked as it supposed to.
> The current status looks like a mess and I'm not sure if there is a bug
> somewhere leading to my headaches or if this is just not meant to be
> working together. If so out with it.
> 
> tl;dr /proc/…/sched_rt_*, sched_rt_runtime_exceeded() probably
> CONFIG_RT_GROUP_SCHED should be removed. A bit of docs should be added
> for the fair server (or the right place).

Thanks for putting this recap together!

> Now. Details.

...

> Without enabled RT_GROUP_SCHED the files can be set. Are they useful?
> According to Documentation/scheduler/sched-deadline.rst it used for
> "admission control" whatever that means. Anyway the fair server still
> kicks if it is disabled. So I *think* this is just something else and
> not part for the docs there.

Right, confusing, but for a root_domain comprising M CPUs, -deadline tasks can
be created while the sum of their bandwidths stays below

  M * (sched_rt_runtime_us / sched_rt_period_us)

and writing -1 disables the check altogether. That's the "admission control"
the docs hand-wave about, and it's also why the knobs can't simply be deleted.
As you noticed already, the servers are completely independent of these knobs:
writing -1 does not disable the fair server, it only lifts the DL admission
cap. In principle we could move this to a different interface that reads closer
to the underlying purpose, but I'm not sure how much breakage it could cause.

...

> Anyway. Could this interface be moved to /sys/kernel/sched/fair_server
> away from the debugfs part? debugfs is not for stable kernels/ ABI. Is
> there a reason why this might be considered debugging and not final or
> restricted from productive?

I think this was raised already in the past, but at the time maybe it
was still to early to say if dl-servers will stick around. They now have
got more users (sched-ext), so it might be a time we discuss a stable
(non-debug) interface for it. Your suggestion doesn't look bad to me.

> Just to summarize:
> - Remove /proc/sys/kernel/sched_rt_*
>   [ ] Yes [ ] No, because
>               _____________________

Yes and no :). We need an interface to tweak admission control, but we
could find a better/different one.

> - Remove CONFIG_RT_GROUP_SCHED
>   [ ] Yes [ ] No, because
>               _____________________

Luca already commented on this. I believe the plan is still to come up
with a DEADLINE backed RT_GROUP_SCHED for Cgroups v2. If cleaner, an
approach could be to first merge the removal of RT_GROUP_SCHED and then
reimplement the whole lot as Yuri and Luca are proposing to do. The
series is already somewhat doing that, but it could be made more
explicit/clean I guess.

> - An additional trace sched event for fair server preemption
>   [ ] Yes   [ ] No, it is silly to have

With 820725b0eb59f ("sched: Add deadline tracepoints") we already have
some of that: sched_dl_{throttle,replenish,update,server_start,server_stop},
which fire for fair/ext servers too (there's a type field, DL_SERVER_FAIR
and friends). They of course require something like this [1] to be
activated. We could add more if they are still not enough to get a clear
picture about what's going on.

> - Fair server documentation needs to go to
>   [ ] It is fine where it is
>   [ ] To ____________________

Not fine where it is: the servers (fair & ext) work independently of
RT_GROUP_SCHED and deserve their own description (defaults 50ms/1s per
CPU, what they guarantee for fair tasks under RT pressure, how to tune
or disable them). Either a new section in sched-deadline.rst (they are
DL servers after all) or a small standalone file works for me.

Thanks!
Juri

1 - https://github.com/jlelli/sched_tp/commits/deadline-tp/
    from Qais' https://github.com/qais-yousef/sched_tp


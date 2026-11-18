Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012351;
	b=i5pmKdmTEp+haw/7SFg4TENMcpxl8EFZlv0GyBs/WEXxpNlcc4HiJ8U0fJQHDq48ZjmT
	 ZOmvR42tshyzm4jL/Dg3FmGzBafZhdGvKoFNoOAEkEOBJgDRSvZ7qUdUic8iAHkLCFpOn
	 k9q/9L+j0fQZeGBBwkJ3J7bPv6cBmcAFgYB3frpxdDc+Dx26YIo7mFswwPZo0RhNcXzgo
	 xfOWbR0+rIQRugaRpNBYDpAMjtLROJ59sIkq0zrb25NZoX+hNt1tRnKMbUJw8XZTWon2S
	 i7pEcYvt7b+Ghf+h7aUgdzjxGEQlz/i/ReZ0s/5zgmB0231IVJIgARQuFHT475jkyqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012351;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=IYa7d2S4FNA7B3qml35ZrjkyJZWT7YLdzwOJhQFTPJw=;
	b=jbfC8HRvzS1XawkgFGseKo+bPzv3mkkYXBsyueuCCSMm+zcHicnjWixI0tkAW2wVL9BP
	 J2pF29R7oEkEx6Tvgf7XfR59RdGs4T2EPxXOmLUW0i4aCqqMLepD+KIRptYLxMghjCRBT
	 jCQaiZtaWKq79BiyXIsS7FjTZJdt3PVjjcHdUCP+tDRIhKuonS7blUQvv+WNVraAoIrMG
	 KPUu7s7bbJUKV9v5a4R9iGshBY5X3G9A+zluWN5I9VnLvhDnFI7RXfUx+N/qTfhoRnUCM
	 w1q64F5Alm4/ExmjR0K1MyX8+aZ/Qhc+JSyuS/Q3DbaNFwrXCyrOwmfj2PRhKdYs3Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VaD+Xsu3;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4537F606A32A
	for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 14:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4537F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VaD+Xsu3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795012350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IYa7d2S4FNA7B3qml35ZrjkyJZWT7YLdzwOJhQFTPJw=;
	b=VaD+Xsu34vU64AKsQ/3FGGJHuzhiLtHQnsCNzlppRoorGh002QJMjXaBegLUGUzUg342Rn
	7KbJ1wjiA/xJYjp9bHq0MqJVJE03JkHdQSHgXQGR1E71KypjsuAwJpoxDG3ik86HAreqp+
	tfbGFOYrFM8UrxhgmYKz9aDlCmcul8M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-CaUkYpQNMyqkhBS_qLrSzg-1; Wed, 18 Nov 2026 09:32:28 -0500
X-MC-Unique: CaUkYpQNMyqkhBS_qLrSzg-1
X-Mimecast-MFC-AGG-ID: CaUkYpQNMyqkhBS_qLrSzg_1795012347
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a70b42bab0so8405055e9.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 18 Nov 2026 06:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795012347; x=1795617147;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IYa7d2S4FNA7B3qml35ZrjkyJZWT7YLdzwOJhQFTPJw=;
        b=rFeFZXVJcsEbjaIJ/HIfJARYPH27ICc4lN4pM7/5S2QiQ8ZD3xpvs4NZ6jipm65uPE
         IXkeNGl5FlTxRYPErOaLRy/zHze05VI7FxMoG4DmR8fZMvVnGm3mQhujvHKSgmfnlEYi
         wLJAZFXObwqjsCs/nhww/917BC2seNG5MpOXli9463Flf9PAKrHPuvxVEoj6OqtKaGpM
         TPrrkzzwcPUxO9nOlqxLTpB2ac8pl+CI6zpLAIAKGaFNmpz4xtr/lxa7rON9m/rq0ilM
         Zezxhq679zlDlS+rGpB9kCRaTIErEnP3gV5ZajvDMgAaqPtuLNNfZcDRbi1HlYYuZPpL
         xEvQ==
X-Forwarded-Encrypted: i=1; AL+hErHaPuAiTh/0WGb762kUDu0BW/cPBOCW0MfOi+ceVxp8zqHwDty6Fe6Ye8oMtydfDZIM9H+rLmbNo+1iEmYl/w==@lists.linux.dev
X-Gm-Message-State: APuU4Z/GeMbjbLMDIonBuh4o5uUxplIyhPEKxh2gYgaJqjGKWoEKgW3+
	DyjqIPyXhEpucEIDKdVS5H8l9j9wxzE8kyIggHBN3n4CKBp7tPpqMAb3t/loni1zPUtILEXEcbC
	TYmddi7y8zjFXZsb25dlKMBzrUGDLpYX1k5gTpr31JQl/JyG/qMOS6JgnEf3yMvvaBFwt
X-Gm-Gg: AYBFou04Xq2+Gvzk4duBSjii7MAekJggJhWz2ekY4ZHFPZMWGoMttCEcVCNGexhS6GT
	cp7Zl3TVFeNdKj7jnSIMYCzj2bxQKOx2NYI5nzPLolSg3vUez3BrTBDAok2Ms/g71Eo0+uE+fCq
	AyKK2KuCxjFGSx1UZPBC6HVlh+5Ke3uPSYLn8dNGLlZ0J9zex+iXw3agRnHbmqLOBuUMbZuMB67
	vtB8yeKTLumJXhuxA3tQAGZJsafH+3IvX82Utngf6ubd7q+01qFjjLG8Q9f15WiE2P4ohyx8LT0
	O3yCvcJblebHUx3nZL19un28pZ5e+kt+LQh9ffkDqQM+iG25+NvIU6b7884sUEnnGFJ6Cez7+AH
	hh0U2R29rRere15GLzHhoA0tngQtO2Fd/3VCUQoRD9+bMeXK1ixr2yDeKGza+Ce0Ll2sL2D1LDR
	j/nJY=
X-Received: by 2002:a05:600c:6290:b0:4bb:6a78:7c42 with SMTP id 5b1f17b1804b1-4bb7d6cd48cmr55544975e9.1.1795012346874;
        Wed, 18 Nov 2026 06:32:26 -0800 (PST)
X-Received: by 2002:a05:600c:6290:b0:4bb:6a78:7c42 with SMTP id 5b1f17b1804b1-4bb7d6cd48cmr55544025e9.1.1795012346150;
        Wed, 18 Nov 2026 06:32:26 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7d2aad96sm58360485e9.6.2026.11.18.06.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:32:25 -0800 (PST)
Date: Wed, 18 Nov 2026 15:32:23 +0100
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
Subject: Re: [PATCH v7 08/40] sched/deadline: Do not replenish a boost from
 cleared parameters
Message-ID: <av2295tJMdwRp3wK@jlelli-thinkpadt14gen4.remote.csb>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <cefacab5f1c0e7617f17e050af4ef5f6db01700a.1794922146.git.mathieu.desnoyers@efficios.com>
 <av2k8JlLvUcBBOhn@jlelli-thinkpadt14gen4.remote.csb>
 <ddd215ff-d6de-4dea-b12a-80948a9b5ea6@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <ddd215ff-d6de-4dea-b12a-80948a9b5ea6@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MdpDxCCsQBjAC_w3oT6TG4Rd6Ou9EsSWCACgRz0ts74_1795012347
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 18/11/26 08:44, Mathieu Desnoyers wrote:
> On 18/11/26 14:15, Juri Lelli wrote:
> > The above paragraph is a bit hard to decipher. :)
> >
> > Maybe something like the below?
> 
> Yes, thanks. The next version takes your text as is.
> 
> > Also for other changelogs, I am not sure this kind of info adds much, as
> > I fear it will be hard to track down in history anyway.
> 
> Agreed. The next version drops the sentences that name the review that
> found a bug, in all the changelogs. The credits to people stay.

Hummm, now that you say it, crediting Sashiko for findings might be
worthwhile (for usefulness statistics etc), though.


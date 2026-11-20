Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795179925;
	b=uFF/HE7HWBbyVKR6Zc5ashIqGjLMcYI3LyFqrYMjPsiZmFIGbblTqIWwL/CdAhr+mbKa
	 J1Fh+MflKnJjTDtKwPfsi8A9wNIC1q0Mxr8iDu7Ut/2ClRP7xdxRMC70LR97FyRjuQAhP
	 4KWSKdMBzWWHfgtVhvANRSDRpFznZmmAMYfpN3Wk33MiTYmCjuo7n2MqVO1u5lZHgMOSQ
	 lLyPWaWRXBfARTuE5Pn1Dxh7uK9z7m97lrQ6lz89MROlO4YUO3dQN/eyY7K9Cr1orDtHb
	 K7eDgniReahUzcEDZLzKTo3s7Ou+dfep5IiSytViGvDcWUSFlOWd7BqKFfcvGrFxn3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795179925;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=P1l8hjvVS49GyIA6u6rGG13XCHYYHrZ9VUNaIusOyIk=;
	b=cFfQC9m/DiQR1gcYw/XyUApPtKs//fBiYvaNLCeQs8hNeukQccnMK6L7nxEhpngLHP3m
	 Nmh/uEpgiZVU1N8G4MgW2wncLXRuLIJ9FernTV5yy1LpUXAN7tclpszH90T/T2OqSlUZb
	 3fqM+UjviN3vF7eIH7V//zeS6XCpXv28InRmDZqkkpM62/W/C1HFvubkv78ODPCgn5lCV
	 qxQ61oI44xKEI+K4QcRCgPHrQXMvexRQwSDjoQP3NjyyKLKOJoIIzaUPCDrOBnp7uyAmA
	 8k4IZ3lQs7sgCGizRoc6KC+OqU4zqG++DyXsHThOk6HKdGTX1SXXz6QkUjoVdPi1dYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B8JbHsW4;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0790606A332
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 13:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0790606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B8JbHsW4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795179924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P1l8hjvVS49GyIA6u6rGG13XCHYYHrZ9VUNaIusOyIk=;
	b=B8JbHsW4w/Cst9pugdy3xsFE8y5jYEO3IdZEIMN5ChSddaoIxa6EIlQL/ecw2hPz76KvWp
	5Pf5KyWadrevcadpWJkL8gGm2d0dNyHIynU117YsIUnWk1S4KUKeKW6zb2K0LVJNMV6tZS
	9WuKre2SwbYUqtA838hEk4t0O4xSMCg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-rohGE0tZO7SjPsun3I_Nag-1; Fri, 20 Nov 2026 13:05:20 +0000
X-MC-Unique: rohGE0tZO7SjPsun3I_Nag-1
X-Mimecast-MFC-AGG-ID: rohGE0tZO7SjPsun3I_Nag_1795179919
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4a370217dcfso689594f8f.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 05:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795179919; x=1795784719;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P1l8hjvVS49GyIA6u6rGG13XCHYYHrZ9VUNaIusOyIk=;
        b=XBeBQfcDoKDoZVH297I28d89jBbuqvLv0oZ5MPerrOxGUqde/Vs+qwTDgSUQwfBL52
         C+lG9esJ0MFrq/85uyh6YllB2N6UdcLlZHE+9Pq6i9oivOZzogawYZdCVSJk4w8HWlX4
         u1k+IW1ViDOi4VnlIJoPBRGTxsUpGBCqvQa1HtXbN8ZxlJny9h3yz0WLDDwI8VHhXbCP
         j6Hr3K2m3lv2hc7hd6ETv9ci4MCRwGg3Y7jRFay65xN+Ios3122NwTRs8AoxiHmNWvBn
         EluFX00AjDegSYipJSML7PS5YuV5rHsWOY6wSxZBet3oZa/4+yZzVTByxnL6fBLf713j
         68Yw==
X-Forwarded-Encrypted: i=1; AL+hErHgCYZyhuVaHbjsm4G/WdN+isznR7Rc77Rou7J9oPSCURwRbA+mfgBs1oEozgNV5IV/PGdJLoHCAHur3nW+qw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/2PB3WS7fIrG3/pq8tVjmeUk7tx1J6ROmtqTKaiQrBiS996Z2n
	02/nqsjokhrsSa/Clb3l3KagJZ95Pfs+d4QRpYN9jNrzUS7ibPAgmAqbA0RWnE5bE6ltmmvMCfd
	c/rrm+DNz82is5hg0dXnTFJ1WfxsJsxXRMX6WdSMSZtF+7uYiid6U64Qv+yDrKoazHa0a
X-Gm-Gg: AYBFou0GT09tKYOPPcMkjWQPZJq0d9yyJejkljvAGbOs73Gi3l65M/4HDIjkMcwP0C+
	faaWMP75AcM6Pcdk2loMziYsIiygtm22vorBPTUfZtTwdzRc6/ZNjo5we7ovFirwGb7It2uVEzj
	Ou7dMtlILh1RL0nolxNRcwqgj/gXe6oUMvGfABw5oXZ/AOPZ2KdtQwYp7edNHi9soSeEzngBlQr
	3GM3P8xn4DvD7EIBFTx6zeg001Baz747lbC0znZykv8bm6KSNGPntjJmSLM1BqPgnzAP5IU9sVg
	tpJTSBxm2Dld2htXkML4IXXwhuSOaLF0+jpXacTExfer0d6OkPxoEDhDXGy4jFIKOJVJXrqest1
	CQhDzOkz0D1P9u7/y+TZ5E2CWhPnxbkE0/axnJBZ1N02/98iMepmGoSDve3QOkHDprmKOhr75uT
	SilyQ=
X-Received: by 2002:a05:600c:820c:b0:4bb:6f6a:1976 with SMTP id 5b1f17b1804b1-4bb887c2923mr64602905e9.2.1795179919563;
        Fri, 20 Nov 2026 05:05:19 -0800 (PST)
X-Received: by 2002:a05:600c:820c:b0:4bb:6f6a:1976 with SMTP id 5b1f17b1804b1-4bb887c2923mr64602195e9.2.1795179919119;
        Fri, 20 Nov 2026 05:05:19 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849247asm85099165e9.7.2026.11.20.05.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:05:18 -0800 (PST)
Date: Fri, 20 Nov 2026 14:05:15 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
	tglx@kernel.org, will@kernel.org, boqun@kernel.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	luca.abeni@santannapisa.it, mathieu.poirier@linaro.org,
	longman@redhat.com, ridong.chen@linux.dev, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, shuah@kernel.org,
	bigeasy@linutronix.de, clrkwllms@kernel.org, parri.andrea@gmail.com,
	m.szyprowski@samsung.com, kayracizmeci@gmail.com,
	weihengqiuu@gmail.com, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v5 00/17] sched/deadline: first bandwidth accounting
 fixes and selftests
Message-ID: <awBFi0bwFt5KoEq-@jlelli-thinkpadt14gen4.remote.csb>
References: <cover.1795115075.git.mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <cover.1795115075.git.mathieu.desnoyers@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J4ab8yS17RXND543QPLvGjcmdwtb7iljLYrdGHc5vkk_1795179919
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On 19/11/26 14:06, Mathieu Desnoyers wrote:
> Hi Ingo, Juri,
> 
> This series fixes 14 bugs of SCHED_DEADLINE. Then it shows the deadline
> bandwidth of each runqueue in sched_debug, and adds two selftests. The
> fixes come first, so that stable can take patches 1 to 14.

Thanks for the respin. v5 passes here: deadline_switch_test 5/5 and
deadline_bw_test 46/47 (move_cancelled skips), also with scx_simple
loaded (the server cases run on ext_server, hotplug_server skips). The
sched_ext selftests pass 40/40, test_cpuset_prs.sh passes, and there are
no splats with lockdep on. So you can drop "not tested with sched_ext"
from the cover.

I replied to 10 separately, with a readability nit that is not a huge
blocker.

Peter, Ingo, I have the impression this is starting to look good, what
do you think?

Thanks!
Juri


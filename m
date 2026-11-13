Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582405;
	b=yxgU8IGnZskhBJIUGYFFdCWdhiKdrDUFvBF4dx3HRcPU65wt6v9wuHrgJIO80Xmund9l
	 bjQYknFn+P/MsXrFDc10U1niQMuNil8gdjVRu2I1bFRMk91h+M6gltj9PurubbwnFTm7z
	 HN/5wl/zmJegP0yFDtYHPbvTd0THA7+L9Wt7bD2aZmxjfOF7IvQT9ybnIUYkn4OQQUPr3
	 vSMjZ/2IksFcCITJNE4xZrDmaWfER+K2oOhlJS4cc02UVhNE5KVq0SRJ0juY0a06gXkMx
	 ZPN6eEouH5CzgiaiqZuaXLgHMLRHZUj1Ds9aR/azSIAB4qNRDRVSYZwS2fcYIPoPgfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582405;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=2Tp6iQjkfangii/DKRnGc80WH6QKMSA/4QcC/JVtYtI=;
	b=CDF7PW1IGlXtdQce9gOj1AylQO64LD4xwTt5cYDx3lOKzA+AYMQlZ7mjKn9J2fPXGSeZ
	 WNKXUEBwJY4NiK4N9IlqQjPVmsMVBkFydOmQkKmeV7MkvGps4LJKLnz0FhOyiLohTB3tJ
	 ssoLkYusUke4LGJVUtCb2MFXazc0lk2l8ZJeKJNxFdHbBi0AkLs1VhNmcREg1yN1FMZUc
	 OuQdTY5UX3EQCZ9W75Qc/dk2O/ic1C/r86+dkDZpws3fklX7gZJrasHBRkmO/w/KYriwt
	 PJTGH2L1JaT1aPT5LCWT/jdA7YQeujHGQn3InrO4CjqqUmK1sdU5iAETMTV03OTTTvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TciBMSmE;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E864460A6F71
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 15:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E864460A6F71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TciBMSmE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794582404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2Tp6iQjkfangii/DKRnGc80WH6QKMSA/4QcC/JVtYtI=;
	b=TciBMSmE/FFXG9MYsN+ix7zwV6Y6/GUs5mmtdk4MHuNf8la8FlUCTpWUPSiAEpOvvbOcOe
	XjOsiRDLwQu3u7vdeSK/7pE6jiIQjWE4OjHh5/Yv9KTgGj/jTqW1e4pG2TfE86saEgepzz
	FBPEkedIRBc4UF6w6Twyl8zXqj5XgQs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-kj5R7q8vP1GelUnvSKlW4w-1; Fri, 13 Nov 2026 10:06:42 -0500
X-MC-Unique: kj5R7q8vP1GelUnvSKlW4w-1
X-Mimecast-MFC-AGG-ID: kj5R7q8vP1GelUnvSKlW4w_1794582401
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a35db2d6b3so6208735e9.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 07:06:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794582401; x=1795187201;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Tp6iQjkfangii/DKRnGc80WH6QKMSA/4QcC/JVtYtI=;
        b=q2MS5EDWRK61yAQb1vl8BN/aZOMj+WFTHIU3RJWsgmPL/2HoPLozGp1rPU89pl7nEa
         DzYP197W7emAkTYiBIBf6Jv/OPjMp6kjFtUzMCmpc+VPm3CGsPW69vxqStWgSEuEtKsa
         xdhkRUVe168zRYAdOIMvaAtBMC7wN8O1oUXXNcKk/apcBFUeP9sIlyoc0zJ1j8fLMx/7
         LwXND8FioBrb8t3QeNvA/5Qz5bHbn+NUg92zhhnUlM44lhWLGFIut+IzXedCCr8Lj8H4
         jZU9wNerUeyy6FakqXmzfocGy198+HUUJ2HGRn6TyJr/XabHBViriH0WFq6Z/we6JjiQ
         FwWg==
X-Forwarded-Encrypted: i=1; AL+hErGIdLJ3FrUt9q/PpUF23IA5nEMoz8XdZd/SZJPf5K0jll5NBpVlQ8rXhMIc6LPCnkXTV3euxzsf8hNQYmkNhA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+3Ea6AAjsfLSDAnNPlRAihf8wpdYVxKhQc0e6ZbJzFRi2i8xpx
	iUW4golXvuLedYb6krgOqkTx3dCyvTL7wDX51N5CzpJ5E0vdAAxYtMW+Iu3HKnEEJAbPVCj3dUO
	We1/Xo7a2RkgAOHrd9auSTIi29k2mpnaQmYCCDDXEQu87pc9TVNkFvlDtviAtNi++ZHhv
X-Gm-Gg: AYBFou2agnWXrzwcQHh2OioBPrEQhL1SNxb7F5+iBzmGeHcUz7EsL6bwPhoa0PCP2Y6
	IhWwPLATXsTnnLutVRiqkmJywiA9Bd5NRfAwWaJyeVrpg4SILmk/Fnz1euOFm/lQDr/4CYJ9aCH
	Q2B41uSLel/+1IXrQXl/WYKWbzoEacbbXe5NAB3mlglFyJq4XR2h1UZuuZO3MmIiuYZ/+i+sIfv
	lmSufdiSdTaYr+Ay+unaxdz2/Wr4jjt1dAd+E89IkdhmlFW44MfRc2OBZ5WA48gJ9x38ZhlPnIR
	7XH0g01KmSAyOrxE/h5wUmtyqXMTr1JX9sMdTFfF2LdWJmPbRjwUM70ba2bqhynVIMg51l/p5AN
	ni+8dqks18cx1jSgdoUxJjqRWuqd/pOpS9KACgX3+3R7RdW+juZcbgcphi0BLxg8Dq1jg+x2fm5
	oRL18=
X-Received: by 2002:a05:600c:a30e:b0:4a6:42cc:bf66 with SMTP id 5b1f17b1804b1-4bb55a5d63fmr51094435e9.11.1794582401481;
        Fri, 13 Nov 2026 07:06:41 -0800 (PST)
X-Received: by 2002:a05:600c:a30e:b0:4a6:42cc:bf66 with SMTP id 5b1f17b1804b1-4bb55a5d63fmr51093885e9.11.1794582401031;
        Fri, 13 Nov 2026 07:06:41 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5d2872edsm20774755e9.12.2026.11.13.07.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:06:39 -0800 (PST)
Date: Fri, 13 Nov 2026 16:06:37 +0100
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
Subject: Re: [PATCH v5 16/29] sched/deadline: Record the root domain holding
 a task's bandwidth
Message-ID: <avcnfTqZzNGLlbHk@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-17-mathieu.desnoyers@efficios.com>
 <avSPoSnNATnwZ8cS@jlelli-thinkpadt14gen4.remote.csb>
 <7459ff0d-d8e1-4fe4-b2de-4b4f06be9bb9@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <7459ff0d-d8e1-4fe4-b2de-4b4f06be9bb9@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PMbwVpPu3uXT6Y62gi3NOw5Hi01BTtnxd07JcISmMxg_1794582401
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 13/11/26 08:33, Mathieu Desnoyers wrote:
> Hi Juri,
> 
> > > +           if (p->dl.dl_bw_gen == dl_bw_gen) {
> > 
> > So, this is not guarded by dl_departed_lock, but then this gets fixed in
> > later patches?
> 
> Yes, but only as a side effect, and the patch should not rely on it.
> 
> dl_bw_gen changes in a rebuild, which holds cpuset_mutex. From patch 18
> on, set_cpus_allowed_dl() reaches this test only from cpuset_attach(),
> which holds cpuset_mutex too. At this patch, from reading, other
> callers still reach it without cpuset_mutex: select_fallback_rq(), and
> sched_setaffinity() with admission control off. A rebuild can then
> change dl_bw_gen between the test and the __dl_sub().
> 
> The planned next version takes dl_departed_lock around the test and the
> update of the record, from this patch on.
> 
> > > +    * enters the class. A runtime below about a millionth of the period
> > > +    * gives a bandwidth of 0. It counts for nothing, and no move updates
> > 
> > Ah right, quite cryptic corner case buried in this comment. :)
> > 
> > This is the 1024ns/2s of the test. Which indeed gets dl_bw 0. Don't
> > think it's a huge deal from a theory/practice pov as to actually make an
> > impact we probably need quite a lot of these admitted (fork bomb style).
> > But it's still weird :P. Not sure if we want to impose a min of 1 dl_bw
> > for these. If it actually complicates the accounting (for no good
> > returns) or not.
> 
> I agree that it is odd. I left it as it is upstream. The accounting
> needs no special case for it beyond this comment: a bandwidth of 0 is
> added and removed like any other. The case move_zero_bw of
> deadline_bw_test covers it.
> 
> A minimum of 1 would change what sched_setattr() admits, by one
> millionth of a CPU for each such task. I would rather not do that in a
> series of fixes. I can send it as a separate patch afterwards if you
> want it.

Makes sense, thanks.


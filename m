Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589044;
	b=Bc9LhiQseWTGeB250z9oCv5XenLdt8N4fVi4ywMWQckUvSTDpTxpY21bRCtYNbsOYVhu
	 sCHnEH3ucGnQUIa7jNUtJ6WJWaht1mKTlJOYfa3wVBeJAM7T/AF0tkkeObZB/fIEhNKnJ
	 fmuzg88ME/piZatKbkU+P73dORcDorEhkGIqs1VxgAgu5VlItujVEJinD3q1QaKlvo8oD
	 5eHjvdCQr6Iiz6SNCwNbdYii2CXCPxSxUvEjnkq1BXrJyCb8Rs2TUuv57KuWUfXkHpVS8
	 wzTor/6R1Va+wq3+LyteQMSgscdxmdii8XXxAmVqOLEy3tlCosurgmJuRbaycX8LGgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589044;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=t7R90zeBhuCAPBYRWGVInzQKZ8XGZNdOKwhHfCCRUDk=;
	b=R/rFZf5Z8vyT5wvFyIiYA8eb0rkcg7jREbOTTHczivNQVKBOg84gXrqJuxAofCZ3mnGA
	 fCLr9WTzZsRUvTdaRxMcV6zY0HsQhGSYcBTfnpyuHqmY7kPMbn57FGW6l1mO+5pYwrIH+
	 ZxNJZJfjmmg/EOaarVTW35g0awthkBFGivCvRYs1SUPAzGiPV2o/aao3wX3yCCuty9efQ
	 V4E5D0Yuo4/nHVh5Cwtn4HJOKHyPkA27MFJoyaR+gpGOO4vNb15RNdF73XSWeNX2bg3Df
	 SEFAOnpXrPCWKUzcXCFlcOxC/eG8dL8DjyqL+L/HC0NPXdqVeV3Ma/NGy3fgwRlKkxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MF3zm1Je;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEEE606A337
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 16:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACEEE606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MF3zm1Je
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794589042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t7R90zeBhuCAPBYRWGVInzQKZ8XGZNdOKwhHfCCRUDk=;
	b=MF3zm1JeiL5WZQ9A1terY6B/MuTQJMZnTn8mF1WR048ahPKE42s9Gn1jts4fs1imaTW9tY
	jxGOk5dUXc8DzDE1s8luwNroMgmVagJ/YgFMtFYUmt9f3t0v72IOdSlm83g6gBBhsIQ6jQ
	Q3HtHUC01cmhXmlPlA9roJG5TnDIyBE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-iLr4Ew3yPx-IylN1S-KSDw-1; Fri, 13 Nov 2026 11:57:21 -0500
X-MC-Unique: iLr4Ew3yPx-IylN1S-KSDw-1
X-Mimecast-MFC-AGG-ID: iLr4Ew3yPx-IylN1S-KSDw_1794589040
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-49034831bb3so725873f8f.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 08:57:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589040; x=1795193840;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t7R90zeBhuCAPBYRWGVInzQKZ8XGZNdOKwhHfCCRUDk=;
        b=G88q3RipbS1OIcvd4XIRcLysQ+zsiwPw1JnDFDQqDP4hhIoVhsjQKZ9RxzNoyndFtI
         QKtCm7ygJbCvrtrVbL6WKLIpPY9yfJCDMqk5v1mm+sV/Ud/Qz/rpVuTwhIbbHE5IauYv
         yrNgS2z6/OYXszYI2psp7ylysteMIASd7tJU5muHL6bLa4WNHBjGKjgJabIiv55NhvPe
         8PICP3KWtXhjMQhO3tXdzV0Fpz6Kk0MsQEODFs96XwBy6ZGMTMy0MfSCO5ml7EWsD1nY
         7RQtcJIfbS6KUF+RUmGhxXq8Kk+t9DMpbOrwlQjJsEmz5PnAKGWMtB58Rk6kcCIqCOGl
         53ug==
X-Forwarded-Encrypted: i=1; AL+hErFBzQtN3s6mcDtvT8o5kw9PVUvzzjOZNC6so00fhi3zDu1jGfGi49+6gCGn4gdmXH4MzhuqJRDnw/DbenFPFw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/CprCn1/jym3BXeaIuoQIRehlXV9hyiGdj2rxAJXj4k0zdOCzw
	xKYvbUEuBwDjAPDAjrO+Fln+bKCbcxiUTiZlH4/GtCM60M6yKqrt5c07/CbypnFyjUXKKXmjeI/
	Fbmbz/mAd2BmZTbvmdxrRE1U/XDwxik8bJdE2PedeNAQtH5Avwnt9UFaIAK2aXQ1URpeI
X-Gm-Gg: AYBFou1Zm0ESGxIY7GG4/+hzzQp+xUOUiWSM4pEnTGh6Zu7yqs0+/wlF4/EvPwEE0dB
	VUX06IKZrsCyP7A4w2Du6y69dmf09mYmHH8lK7iw5sYAmiaQOXOr+3s7k9hjv5VZijILOeR+wem
	QIL+L1AbDMqy+tpyeVXHMIyLtTgUCRbwUV9nipz8CSIfFL+clCCopl7hrGit7Gr2M2rDjHcfnou
	AgFaaHwAjUz7yTBsBFxQwUMS/yJBjtqbb0FRiPWaGC88v2+0Fk5btmq7m0bjDPqx+ADfBCzC/jC
	r/euPqzC+mtNOPv9Mo9HUbtx8BN5R+nfoiSAAwzcvGBmXzI9BsuLlijnFK49Kw98E/DBntODrpe
	SOEQ0PrWs+1uIRRYrtGowJecVCVE1nrl6Ntex37kTI5gqgXaPJVgSAqs/F9wfoKEQNZYEZkFa1e
	4JPQ8=
X-Received: by 2002:a05:6000:4804:b0:49d:57b6:55eb with SMTP id ffacd0b85a97d-49d57b65632mr3158286f8f.17.1794589040090;
        Fri, 13 Nov 2026 08:57:20 -0800 (PST)
X-Received: by 2002:a05:6000:4804:b0:49d:57b6:55eb with SMTP id ffacd0b85a97d-49d57b65632mr3158249f8f.17.1794589039729;
        Fri, 13 Nov 2026 08:57:19 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c604ee47dsm5790370f8f.38.2026.11.13.08.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:57:17 -0800 (PST)
Date: Fri, 13 Nov 2026 17:57:14 +0100
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
Message-ID: <avdBakhOOFb_j6y3@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-21-mathieu.desnoyers@efficios.com>
 <avWEta7b9X4K6hF7@jlelli-thinkpadt14gen4.remote.csb>
 <e21aaf40-b929-444c-b707-3200e21d7301@efficios.com>
 <avczaaXEh_xUhxpa@jlelli-thinkpadt14gen4.remote.csb>
 <3b2419e4-3874-4ccd-8af1-3ca76df20717@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <3b2419e4-3874-4ccd-8af1-3ca76df20717@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uQZhX9d2CuRYl9xXXfgMGgmxgeI5iYcBh18VnlDpFTA_1794589040
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 13/11/26 11:14, Mathieu Desnoyers wrote:
> Hi Juri,
> 
> > I believe we already have (maybe broken in-kernel) EBUSY on trying to
> > hotplug last cpu with bw standing?
> 
> Yes, in dl_bw_manage(), for dl_bw_req_deactivate. It refuses a CPU
> offline in two cases:
> - the CPU is the last one of its root domain, and that root domain
>   counts deadline bandwidth;
> - the CPUs that remain lack the capacity for that bandwidth.
> 
> Both look at the root domain as a whole. The planned next version
> leaves that check as it is.
> 
> The new refusal looks at each task. The root domain keeps other CPUs,
> but none that the task is allowed on.
> 
> The case hotplug_last_refused of deadline_bw_test shows it, in a guest
> booted with isolcpus="domain". I1 and I2 are isolated CPUs, in the
> default root domain. H and K are housekeeping CPUs, in another root
> domain. B is a cpuset of I1, I2 and H, and is not a partition root. T
> is a deadline task, counted in the root domain of H and K. Without the

Oh, wow. So, this is indeed possible today, but of course completely
broken from a theory/AC point of view. Urgh. :)

IIUC, what you propose for v6 makes sense, in that at least it should
close holes we have today. We will then need find time in the future to
address what dl_bw_capacity() already points out:

 * XXX Fix: If 'rq->rd == def_root_domain' perform AC against capacity
 * of the CPU the task is running on rather rd's \Sum CPU capacity.

In the example above T should be restricted (and its bw accounted for)
to either I1, I2 or (H,K). It shouldn't be possible to admit it in a
cpuset spanning both isolated and housekeeping cpus like B.

Thanks,
Juri


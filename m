Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582268;
	b=fmUxcbPFdQKTUTy0pKOaTlKJiNsKkspQ0OwJm7ZR19jm4C3kWXmKXb8s7ObrxI3kzLF9
	 aPugjWEASEMTmzqvtoiX14BU4iOiWBtDtKKJ+FVtzGvPF/gJ3tZHrE72x0UjbfzMhHc6m
	 UXL8onzMkPh+b7W0q1pfz5efCpSORr0dc/m9TpK/l2hJk2cFzXCSxcmpP7UDOTdY1XIez
	 JOh0HXZsRuoYGGrJkbUzGZtVV2TchbsKxMTDzO2mHfjCvjO5FWBk1UniEyPlin3oIneCn
	 UUhZ68eLedYIqG6LW4oeSITBRBeOh1DlJyZNRSowarO9NwpiaKhNZF5GY/SPa/sh99A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582268;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=VBm4qF0y5CrLsLbvNlcB/jDiXe3RpYSa+rFP+kdVVgQ=;
	b=WElrVafD3JmUbnvcLLTpff0WNr6oXVump0VoPS9xuf5pW4q5W01Oi5F2kwe0xwX5A/Qt
	 p6rYqw7JbYaj1HmATCw9rt3jbHXzx4s4wF5U7dB6Llaz369VQUpkGWG1xeEDPccOqvM0M
	 YE9I+kPFlBorltUom7pAdh5bUxntXut5kXTKoPDtt3hP+9QmsR67V4cSSkzssgAADFuch
	 sDfjFOmKHebEjwxjJ7xkCCSs1ztwKb9laJN0b0YtLlgguAGIcBmYkP9VSEO7/bkvFEmDB
	 +kSoceBaYtt70Ei2x7g67qo88uc0DKqGHX9W/bvzL0sTpqfb4Axd/eosI0PZ8vFd8+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KLX4lNgu;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87386606A33B
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 15:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87386606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KLX4lNgu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794582266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VBm4qF0y5CrLsLbvNlcB/jDiXe3RpYSa+rFP+kdVVgQ=;
	b=KLX4lNgujzpcMIQL7Nldo0j+S2mUCQ2SMEwgptTSlos4w41Eecs1hiwkPKCeJBoh4Smm99
	Q0d4mNrk1IdzUywpli0YZXJ2nJk03ed5PtYIupbrSNZLLowUUZeV7Zq46ZalfVBn53TQtQ
	Y9Ilz+24ykLOvlTJl+jfkK4T7eJsxmY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-pA4m4aYIMpy6DnchcVLk2w-1; Fri, 13 Nov 2026 10:04:22 -0500
X-MC-Unique: pA4m4aYIMpy6DnchcVLk2w-1
X-Mimecast-MFC-AGG-ID: pA4m4aYIMpy6DnchcVLk2w_1794582261
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-492b5408dedso553870f8f.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 07:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794582261; x=1795187061;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VBm4qF0y5CrLsLbvNlcB/jDiXe3RpYSa+rFP+kdVVgQ=;
        b=h43tfZ5mmIrNp2Sz7RYOudhRBTx8BPkItvJgBR4cJ4LJ/rj5ICb1WPDmaBb+dEMdkq
         Bimh8grSBiYNcrdCaAsIHfPefN686AcI7dlR5LxkoqJEioWbRBVeSqWqmbg0F6WR4JRf
         YPNNWkzMbayiq1uG7a88eyNZ/EgEQ/3uQCOjp3rpgrowm7soQjDlzzrEToC00h/N/mhn
         hWX6fcOaFEdQw1ZXpI8tRhd65LQU5Ud5I0Qy7stQE8GjeXAPhj6fhNQ1OJiZEUNtC7Nx
         SSipjBd6uDWy7rk05dTrtF4XVWNC/+DsTfbq3DZi1jEV2vJmBFRH/1tQUTsDKNUMZWvp
         7IIg==
X-Forwarded-Encrypted: i=1; AL+hErESswFxg9csUPeU8TOzpBZvLTs2VZjzxtXnnNaoBgd+6CBmIhROaqZ7I+njFYkQlmdBqlmJBCJRenAt03kn5Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z8IInpuI+CGfrPPxhWxJQ5beeQz8O0U9lJ4wZWAb5+e18D6v+ZB
	E0TdR/5rOf7zpmRFYbEU+Zr8CoXgHClQwuECTCy3ZvWOgZvifhVb+sq/pe3E0lzXHS/+inn97kY
	1jZnF3YjSAvjp3uU52xu2hvWyuPawzqq46F1Wux363/jBvprl8PvafF8GGqO58ownVQ7f
X-Gm-Gg: AYBFou3Rcja7MhTTbH6x5f1NYhMQyITU4k65+cgU3aHsNHx5plSWU+sAZfrtyEq1cH0
	thAdfUzwXy4SI/x2C1/bv05oipwymmYWv+09qw3TlxwgZqTxEzIIBsEDF7iNX3qI2RWq4z3C1I1
	8kGqcLBgF8Kdgeg/kJyflzlnNAX2utNIA19T8MraMOYK3MC4+MCcxmqBxKGdS6E3RcnyhUrojs8
	RjzTCGymScI8K80x8rX4vJuB50vltkppIO4wHQjCdAMLOPym9M1fi3BV5a/+JoO7R7THWJtRHBP
	Z3PfkJfdEjuKdGIB2AG9sVV92F7zvsKClc82fPVWrqtH+uBAVYC1AvLYzuVCsaCbd3pvlHHwH4X
	1rU5qL+r+7Z3Fahr5/lRE/4/X2Ukp/YUnH6jIgZrLfOsoAlihC9+k8r0tMtCrfzNMrwmY5wNBas
	zk2y4=
X-Received: by 2002:a05:600c:a44:b0:4a2:a6e:80f5 with SMTP id 5b1f17b1804b1-4bb55a45045mr59742635e9.11.1794582260655;
        Fri, 13 Nov 2026 07:04:20 -0800 (PST)
X-Received: by 2002:a05:600c:a44:b0:4a2:a6e:80f5 with SMTP id 5b1f17b1804b1-4bb55a45045mr59741585e9.11.1794582260021;
        Fri, 13 Nov 2026 07:04:20 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.158.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55af2901sm65285595e9.13.2026.11.13.07.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 07:04:17 -0800 (PST)
Date: Fri, 13 Nov 2026 16:04:14 +0100
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
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v5 26/29] sched/debug: Show the deadline bandwidth of
 each runqueue
Message-ID: <avcm7pyPqMx_r5Pl@jlelli-thinkpadt14gen4.remote.csb>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-27-mathieu.desnoyers@efficios.com>
 <avWWlEGGqVPYkuZw@jlelli-thinkpadt14gen4.remote.csb>
 <bcf6f03a-d596-4afc-9d3f-54219935bc2c@efficios.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <bcf6f03a-d596-4afc-9d3f-54219935bc2c@efficios.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qcsZ8Y_jb0-rvOlNODhHA2Dc71vaF3eXy6mZVJ0L1Sc_1794582261
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 13/11/26 08:36, Mathieu Desnoyers wrote:
> Hi Juri,
> 
> > OK, but we will still not printing additional useful information like
> > extra_bw, etc. Not sure if you are aware of tools/sched/dl_bw_dump.py
> > drgn script; maybe that is already useful for the needed additional
> > debugging information?
> 
> I did not know that script, thanks. It shows more than this patch does.
> 
> The two lines are there for the selftests. params_waking and random_mix
> of deadline_bw_test read running_bw and this_bw of each CPU from
> /sys/kernel/debug/sched/debug. A selftest cannot rely on drgn and on
> the debug information of the running kernel.
> 
> So I would keep the patch as it is. I would not add extra_bw: no test
> reads it, and your script has it.

Works for me, thanks.


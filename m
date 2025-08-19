Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBAB32A3EA
	for <linux-rt-devel@lists.linux.dev>; Tue, 19 Aug 2025 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602943; cv=none; b=E71rcqTJ2AMIpJe/0j0CaerpGbqu+EcZtHFwU9XAoXX5wdVGi2FiOkm8CWlQcKr2lrY9XG2YjS+03Cn6+2ebr0qprY5U1wOe6xGNPCmuaIDSt2VBO3qRvTWZR9TsLp0NEwJs2Jw8bf59AqUudUC8hlhtv0ZpiP1OcDdbko31tQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602943; c=relaxed/simple;
	bh=yN/tqf88Q58Z6H9EMyDAffkiYLu52FY0x2WiMpB40Og=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bqxOalCG5qSg8h435Gq+JT8z94t4GCfvwZlvU90ahNy8MAcSSE7P13Sfhx2zEXpbQxS9E3Prm8zvKtxx84nh0rE/NiThojwfJhSbiY+VPzxJwi3DcMZ5ZaXAv1Ob1S+KkenxP3u+zbTs0rAZqYtr+sgS1k5UBHzplyZqgyLwrXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQG59jPR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQG59jPR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755602940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yN/tqf88Q58Z6H9EMyDAffkiYLu52FY0x2WiMpB40Og=;
	b=SQG59jPR2S4dYhax/LT4mBwDAZHaGkoN/5ouXgXPi2o3jzvGeD4PFWQo3iUsB4fszOpYMc
	kAFtOszUxCX6n53SJ8hSZQpSRMojnCKpLTtaSN7Uc1B/8+bzhJU4Rt9W+NKq5/1qJsrzjh
	KNZ8Rmk1iXvB9cq2wcIfJHP4VVROo58=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-K2_n0jcgNL-F_G1wbVxk8A-1; Tue, 19 Aug 2025 07:28:59 -0400
X-MC-Unique: K2_n0jcgNL-F_G1wbVxk8A-1
X-Mimecast-MFC-AGG-ID: K2_n0jcgNL-F_G1wbVxk8A_1755602939
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b134a9a179so25002481cf.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 19 Aug 2025 04:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755602938; x=1756207738;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yN/tqf88Q58Z6H9EMyDAffkiYLu52FY0x2WiMpB40Og=;
        b=Cd+0oahkv+SINHz5L72G93v/RAG9eGWgys6x4hiDaNuWMQW22nuM/LKANAugFxu4cv
         BabuWXnjGNmuGn/uX0AdfV+Io/Gt+0ExGJuZvzfZJsWRY4MYHxyQV+JTxQ3PU9dfd7uu
         AfNgd2zUrk86R0v0DYNIwiiefwCLOKIRj6aEUzwsijXxIJzrrcOyzUOFE0naFk2Zdp+L
         xbCp7N18DBs4HGC7L2S+eNR/b80D008EwG+sY9oIcNGtOeetptaAV48jHt2zYPkmUUWG
         rwKSOx3jO/S9mbSFfvPVmtbYhGi7IPRwQkBuLKIi+egQWtmO0DLjj4aI7eRbyNi72Mrv
         JEtw==
X-Forwarded-Encrypted: i=1; AJvYcCXowyNPJd0uFk6/VKliG9K4aV8p7myFs/I5q8qOKBSNmLMmqvepQrD6Tek1mctu/UZOfLon6RHq5TNLtV5SFg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6zwNbOvbAjY1Np2i+Q17MISe7tijdxs2IjdKmBdVZQjg9WYwM
	vSNFxqtkLRqiNrT0o5xEh1mT4dHVfb0pcAH4PCaKiclfVBHunx55N+ngb0p7keqGxU7TK/F/9RH
	g7TDiHLH4mgtSE6GsSDtobJ9oM9oiVowpTsAp1JLjv03DpfmrFxY16u+yaatLJ/I0o/s4mddDjx
	/cGsBvLrzLowHgwqD/A38cCRp1JrziIMefbwOwom9wT201R5kz1Vn0
X-Gm-Gg: ASbGnctaLS3cpoeofmnhVJ3x1gmF3l/kH26EDqs69wYfeFWpkGzfQvlTS2NrrTeqj1z
	XDOuofJlt/afS1F5AtU/es6pUdnKzFj5CHmKRYkCY0dHYXylgFFnMI++YZnmOERMtFzwNcjWJOJ
	qgeZheIiXmCSElYwanaGpszHxcrJocLiBtYLNWkElqWuLX3ARoxfJGq6qulWWVtPO7YgaP2IovF
	jhhvtAfnBsygRkIVdV8FPph7B71DDV39cYxkZeGqPXHOtQd19HpZqWCKT523RAdAVYfplJksNJQ
	HKuMRaU1hVa1vLn88/kKbghxTuO0YvxldMeFBcDELn4fwzoh4mq+dmP/8NQbQAH6yURcy1TCrxs
	yYOKbqxXru8o+I2P2NGT0L+GG
X-Received: by 2002:a05:622a:1928:b0:4b1:dd3:e39c with SMTP id d75a77b69052e-4b286f2e04bmr20483221cf.63.1755602938174;
        Tue, 19 Aug 2025 04:28:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPZBzGDST7GlM+XQKmde0ePwa1UT5EmiwV5BKA+4YIL0w5B15B4PBW2ZtFZBedOpfvVu+fsQ==
X-Received: by 2002:a05:622a:1928:b0:4b1:dd3:e39c with SMTP id d75a77b69052e-4b286f2e04bmr20482811cf.63.1755602937732;
        Tue, 19 Aug 2025 04:28:57 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc5a17csm66426751cf.13.2025.08.19.04.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 04:28:56 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Xin Zhao <jackzxcui1989@163.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, mingo@redhat.com, peterz@infradead.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, will@kernel.org, boqun.feng@gmail.com,
 longman@redhat.com, bigeasy@linutronix.de, clrkwllms@kernel.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] sched/cgroup: Lock optimize for cgroup cpu throttle
In-Reply-To: <20250811160454.884224-1-jackzxcui1989@163.com>
References: <20250811160454.884224-1-jackzxcui1989@163.com>
Date: Tue, 19 Aug 2025 13:28:52 +0200
Message-ID: <xhsmhzfbvh7nv.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: srxQzUT6jvFxRSvpJnZja2OxBDniKU_vCK-xBeJ3vLI_1755602939
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On 12/08/25 00:04, Xin Zhao wrote:
> On Mon, 2025-08-11 at 22:18 +0800, Sebastian wrote:
>
>> Yeah, please have a look at:
>> https://lore.kernel.org/lkml/20250715071658.267-1-ziqianlu@bytedance.com/
>
>
> Dear Valentin,
>
> In addition to the information in my previous response to Sebastian, I would
> like to add the following point as a reason for my self-recommendation (to
> explore my patch for solving the cgroup performance issue in RT-Linux):
> RT-Linux is a system that places a high emphasis on real-time performance.
> The fact that regular tasks are also included in cgroup groups and throttled
> suggests that they are relatively low-priority tasks that are not expected to
> interfere with high-priority tasks. Therefore, is it not a bit too late to
> impose limits only after returning to user mode?

Throttling is purely a CFS construct, and does not affect RT or DL
tasks (outside of the lock contention issues we're trying to fix :-)). If
an RT or DL task needs to run, it'll just preempt the CFS tasks, it won't
wait for any throttle or other mechanism.

> Furthermore, when a throttled
> task is awakened from S or D state, according to the logic of "imposing limits
> after returning to user mode," it could cause that low-priority task to wake
> up associated low-priority tasks one after another, leading to a sudden
> increase in running time, which contradicts the relatively precise CPU usage
> targets typically required in RT-Linux systems.

I would again say that's not a problem since those tasks are CFS.

> Additionally, I believe there are still many areas for improvement in my patch,
> and I hope to bring it to the community to gather suggestions from experts to
> see if there are areas for iterative improvement.
>
>
> Thanks
> Xin Zhao


Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EFA3B585C
	for <linux-rt-devel@lists.linux.dev>; Mon, 15 Jun 2026 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781555340; cv=none; b=TnMeD63v69LgwCZwdHpibUUq4eI40/9MMwhTtt/AWgSg6y1kn54Deda76IsxAZUxD4mG9jtbLYsSF6DnwAuQvShXpwsyewKvZ0ZDC/S5qCXj7eD1S7WVLAepf5o0IEqMb5nXCC3HgZmBiAmCIfsQKqoQqpnsmHLbFSFVAwFsKp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781555340; c=relaxed/simple;
	bh=3W+exRfVeOk+9d4eMCZYeHa57RR+U+1NmggjR9Z7Tho=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=g9ddWuG+cf3wXPBMcSYsxO65id6tyhw0RiEn909OR2fn09tqWqL6q4c3AabV14O6MPo6QJxD/d1JORvHUq9OxEAEmojYo+VV5aNH5SRuU5qHZMxtECTDffg007ERp9G0Hvmoo6ObrXY/Jz6h/Ji/5gwgwqwzDZknLGdlMmIyn78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHievx7+; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHievx7+"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4863a7dac63so2292474b6e.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Jun 2026 13:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781555338; x=1782160138; darn=lists.linux.dev;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiFoued8hhJkTkOiQh/Lgu3tiJjlRn9mesPkFyFrrsg=;
        b=WHievx7+1mqk38e4llSW6CozltBrDbAwgAVmkcNG9+5MU8Z8+mhT/9HNps6ArlbBq7
         JzPeIs2Cnvmaxk6/PMKFaMEpRrWrcNNVKDkKVk+Llenu08MUVHx3gLffBh1rBQoY5OP4
         sQJkFyKSX26uYGUqI/0+Umh1zMNIFsSCooR0qr1hbThiSZkKXRxGVKS7m8n0KqEhiivD
         ZuURboDG3lROBLA0NJq9i+EOg162Jx5knoeNI4Ilu4HaOlM8hxg2cPD6R73nCPrczKps
         WXz3sIPhwqGeUKnbmvyrqHZqCjt5OTN2HeAwYhzR2MHPaBQZqyd/v+FRrEpCxU0bet2a
         gOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781555338; x=1782160138;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iiFoued8hhJkTkOiQh/Lgu3tiJjlRn9mesPkFyFrrsg=;
        b=Ml9b1clqWfeH3wjEVcVFEZdQhmRwy8Iuulea8oW6QzY/3QJtBuwuQG9j3rnl23LwaN
         l+hJ6hkq1fs+g0BYa2qMIQw5BYtdGYRTzlsjP+djVwb1b2bktfNiHBnoldRVdlZeAHI0
         Dwj9Nac/bu4c5Ik0MfdkGIVGFXXAhuBwtiG4sbGkUr05qa7ohbRtkOl3qRULSkX48qyH
         ybd4EBJ0MWJgNQeBhKx4diNKnz8O0USQSjvKqy8xkm4J9NrgRN3wbL3pYziTJtv2zlXK
         buHQJOtjngus7gVVXi3+0pRN8NMAvI4m4L+mWyPd81UF1KEEtN2Jm7tVhSppBpL+nynx
         DW5A==
X-Forwarded-Encrypted: i=1; AFNElJ+jIv0ASgeHczK9RlaClP0uidP/23yOGXwA6XSX8nxis4fk0FJj37vR+w6RRMZmQ8wwDzABXFhgdJzUpyLiJg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7JeJk/94afiJKtWRZBdZcatoVuvfXOIvHSA56Q+DjZRTzanqW
	ppLAhBQMZmRgjgEZip0fb9IaDliDFvfI5L4u+RV/z8+d38wl/Y503CKa
X-Gm-Gg: Acq92OGSuDHxl10DMJ+QqtW41VfYrGYOuCcF0KK20HfrOta+K33HSQv6siOpIuVHv4b
	zhP6j7oOu+XoIfUuc2JsbJ4UTpbxOQxASpf8Yfopb1w7/nnroJssT7pMg5eTDiBZ6Y7hdKxpKg6
	xob3hM1K0BVyNFnNkIYHzu5I2BAOvQaUAOg9GjS6vr2xHUpB8DmM8zWWW+CaHhH1ClUHFsgB3Wn
	6g4MVa/9s3AJ5LQwU6HA7Pa826VMewa01o7anPJEuL9MG8KcahnvVvpiU7MYPoOQryo0nK0qGtv
	3GsIouOtGm7AuBP+zwM5E2KaUSRqJ6bBFAp4quuAYsN5azfj8KbQsDZBPZN1WiO5hwMVEC9Ac+T
	Hr4dX7+KKRjzxdtf+w/iBAkp5cRbKUm1cpl6uaf1+1Gb+e7kIcNpPIP/QnuFf2BrV6igtaEabNY
	QJWnfLLNKc9MeK6yBPheBYGShZIW6Wj2R5INfLaFajD75vSJH4ePcW2ZVzJU7e8zD7FEMqvOpbr
	hZI5BZhCUaVCbbsXQ==
X-Received: by 2002:a05:6808:690a:b0:47c:b38c:a19a with SMTP id 5614622812f47-4884c10168bmr462076b6e.14.1781555337911;
        Mon, 15 Jun 2026 13:28:57 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4d::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875ddd9fd3sm3252791b6e.7.2026.06.15.13.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 13:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 13:28:55 -0700
Message-Id: <DJ9WNQFQ2B2R.1JSNL1RNABV6Q@gmail.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>, <rcu@vger.kernel.org>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH for-next v3 0/9] mm/slab: introduce kfree_rcu_nolock()
 and improve slub_kunit coverage
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Harry Yoo (Oracle)" <harry@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Hao Li"
 <hao.li@linux.dev>, "Christoph Lameter" <cl@gentwo.org>, "David Rientjes"
 <rientjes@google.com>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Puranjay Mohan" <puranjay@kernel.org>, "Amery Hung" <ameryhung@gmail.com>,
 "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Josh Triplett"
 <josh@joshtriplett.org>, "Boqun Feng" <boqun@kernel.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "Pedro Falcato" <pfalcato@suse.de>,
 "Suren Baghdasaryan" <surenb@google.com>
X-Mailer: aerc
References: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>
In-Reply-To: <20260615-kfree_rcu_nolock-v3-0-70a54f3775bb@kernel.org>

On Mon Jun 15, 2026 at 4:05 AM PDT, Harry Yoo (Oracle) wrote:
> Not the best time to post a series, but didn't want to delay posting
> the series for too long. no pressures ;)  This is aimed to be queued
> for review and testing after the merge window closes.
>
> This series is based on next-20260612, and is also available on
> git.kernel.org [3].
>
> To RCU folks: It would be great if you could kindly take a quick look at
> patch 4 and either ack or nack the patch ;)
>
> To BPF folks: Ulad asked to share workloads to measure performance
> of kfree_rcu_nolock(). Unfortunately, I focused more on correctness
> and have not spent much effort on that. It would be nice if BPF folks
> could help evaluate it on their relevant workloads.

kfree_rcu_nolock() needs to replace bpf_mem_alloc which is backbone
of bpf maps and bpf local storage.
So all of the selftests/bpf/benchs/run_bench_*.sh
will exercise it one way or the other the replacement is complete.
In other words performance is absolutely critical.

>
> To PREEMPT_RT folks: The most relevant part is allowing
> kfree_rcu_sheaf() on PREEMPT_RT (patch 6). It carefully avoids sleeping
> by acquiring the locks via local_trylock() or spin_trylock_irqsave()
> to avoid sleeping within a raw spinlock. When trylock or unlock is
> unsafe, kmalloc_nolock() always fails.
>
> Changes since RFC v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Reduced complexity and intrusiveness (Uladzislau Rezki)
> -------------------------------------------------------
>
> While discussing concerns about the complexity of adding allow_spin
> handling with Ulad (Thanks!), I realized that adding complexity to the
> kvfree_rcu batching is not strictly necessary: only slab objects need to
> be batched, they are already batched by rcu sheaves, and slab already
> supports unknown context. So it is enough to implement only a minimal
> fallback for the sheaves path.
>
> I tried to avoid making intrusive changes to the existing kvfree_rcu
> path as much as possible. struct rcu_ptr is renamed to kfree_rcu_head
> following Vlastimil's suggestion, and it is used only in the
> kfree_rcu_nolock() path for now.
>
> As a result, the complexity is significantly reduced and the series
> became much less intrusive. This is also reflected well in the diffstat
> below.

Overall looks good to me.
btw sashiko was confused in few cases.
Not everything that it flags needs a fix. Sometimes it's not an issue at al=
l.
It only sounds like one.


Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC2228A731
	for <linux-rt-devel@lists.linux.dev>; Mon,  7 Jul 2025 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751877885; cv=none; b=nfmhmv2ye6punk+ggkzmWT0h/mGemeWRrk6FMflN0pAgHZ/A4M2FsdSduRoSBLSy54kpA400oz/vafUpnVAOmPz8eCGFWzzweJidADeIC4yxlSO9B1qbPHDhrQCrpyftNhpL/V42vZKiaNvGHrgn3uaAgrW40hxQsRfVbZIDocE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751877885; c=relaxed/simple;
	bh=hUt8m/w83ZB6JL77qJE4vWxGp6IaBcDnRqCkmlVggaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tx6TrMWfwpS3K/hWYegHqiGzjtE/Ksp4++hMIsnCuuHHs4sHT9KnhK1Vx4dFzLfettPSj90w4ufKfmzQbowqcDezFInrJIb9m1jJGF/pFT2mh0cip2HDsnonDq64+jwYT+SMRiFmBH6ThFzvcmFQ+JtOlzXUg3yTB2MVNfQ2K0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t+4ylqAF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DXNsjw1R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t+4ylqAF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DXNsjw1R"
Date: Mon, 7 Jul 2025 10:44:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751877882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fm2v9rBCIXUzUrmt72RQoSJ2B3nGVKZtSeUnw7U71lE=;
	b=t+4ylqAFKKKS0Fnxd2Xu9iu32YKM1NnfpW/+0pHS+0au0HgBiFNy0Nt5gJOF5e0ZZffY1W
	3YtmvYAJ/N0zUs4rG8UZ2K0BbT2u5anICCo2o9pmFvPTFfiigpDKyt/V5WNwzf+Q6w1DcP
	2pzowlBtvIlVPRgs+dmVQtRmC9wIn2rd7cFioiSwVw4YOgScPpThKijTVUxforFFrHWp5j
	8zdK2Tgt5Yj1eteg/AhnlUtU3nUGoVlAhpX9XdV3ibv6lGG+vXrSkQfH5Wz4tf9bGrHQtO
	A3Y+Rk35j8GdzGT422e0D1Moui+/gU1CKuVizagTVQ9sbKPSYkzMq423VC5Ypg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751877882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fm2v9rBCIXUzUrmt72RQoSJ2B3nGVKZtSeUnw7U71lE=;
	b=DXNsjw1Rz8o3UEgW2ia+AqFrm41ZxPUtMXbKupeV+oHgS9fcSLpCgmQJtAf+k+HGPO3ImH
	7+CcNj2HvdpaZdBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: glider@google.com, andreyknvl@gmail.com, dvyukov@google.com,
	vincenzo.frascino@arm.com, akpm@linux-foundation.org,
	clrkwllms@kernel.org, rostedt@goodmis.org, byungchul@sk.com,
	max.byungchul.park@gmail.com, ysk@kzalloc.com,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] kasan: remove kasan_find_vm_area() to prevent
 possible deadlock
Message-ID: <20250707084440.9hrE23w0@linutronix.de>
References: <20250703181018.580833-1-yeoreum.yun@arm.com>
 <20250707083034.VXPTwRh2@linutronix.de>
 <aGuGcnk+su95oV5J@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aGuGcnk+su95oV5J@e129823.arm.com>

On 2025-07-07 09:33:54 [+0100], Yeoreum Yun wrote:
> Hi Sebastian,
Hi,

> > what is DEPT?
> 
> Please check the below patchset:
>   https://lore.kernel.org/all/20250519091826.19752-1-byungchul@sk.com/

Thank you.

Would lockdep see this if check_region_inline() would have something
like (minus missing exports, just illustrate the idea)

diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index d54e89f8c3e76..c74e8e0863723 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -171,6 +171,11 @@ static __always_inline bool check_region_inline(const void *addr,
 	if (unlikely(size == 0))
 		return true;
 
+	{
+		struct vmap_node *vn = vn = &vmap_nodes[0];
+		might_lock(vn->busy.lock);
+	}
+
 	if (unlikely(addr + size < addr))
 		return !kasan_report(addr, size, write, ret_ip);
 

? Just to understand if lockdep is missing something essential or if
DEPT was simply enabled why this "bad" accessed occurred and was able to
see the lock chain which otherwise stays invisible.

> Thanks!

Sebastian

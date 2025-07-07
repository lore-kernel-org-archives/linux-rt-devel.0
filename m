Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38A6199934
	for <linux-rt-devel@lists.linux.dev>; Mon,  7 Jul 2025 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751877039; cv=none; b=fz+WWGPk6rfJD694pKqg8Gm5m/e/G4XPVUSFD38uoxsP+riMvWOL8jXSAH3At+Tp95RUfGANooeyjwDRQj+HKXeiAG2sKSyRFYTOUFyMHbobXGDhNlFrlwGbWlZsoo5jx3/eO5UtLkkgD4Mx8Q+KTOWQwFwUkLQJk8oR5dnRBjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751877039; c=relaxed/simple;
	bh=pneG73bg/LVzrOhRvixJzllQbSTiEbr5I7XeAi0I1XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpJQW4fl1rH7nNKzp9UK54C3x5yMkM4DXTSi0OdtUR9c9JzUHsUrY6fj5D1lT1LCY5YiM6ShGGPEGifWnRAF1OW3v+o3QFjiBVPVZ9aJLKU/ZqXcFRUUQH/XNecRHYc6liR0uNd1C212fyAZB6RovoviwTv1/azz9CkD+ogFPhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GQkePXi/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1JxpmRK7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQkePXi/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1JxpmRK7"
Date: Mon, 7 Jul 2025 10:30:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751877035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pneG73bg/LVzrOhRvixJzllQbSTiEbr5I7XeAi0I1XY=;
	b=GQkePXi/UanTnkkOb3q4zQ/6iiv9hIgWUny550yuNzvY0o0uolPNpbd7GWU+sd9VgYR1yP
	0T9sqF+Rvnlxh6hrGNmSqLaSoyBYkZemLVyu6uMar/D5wRT232SJtIn/tTW8b/7bS4UQGn
	Aatihi0Q1OIObiQ41FPbE9l8YAbN7z/Rsv9/DEC+WhnoVJQFw+wYF7YxSkKNsSDem6Kbum
	R7gtzpiq76/k6vD7HybUDXG4AQwvm5VdBHzHn8DEIfUMVzbAUgu4HY28JmfE9uV6mB/haU
	ZGgaAEBbxmE2H9ipsWKwA2C9sjex5bzdaSpHUfmAdCVtF1xa7JgRCAMQSEk13w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751877035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pneG73bg/LVzrOhRvixJzllQbSTiEbr5I7XeAi0I1XY=;
	b=1JxpmRK7DqYP1zMz7sw/1Za04QOEhxXfFYtGiT6fVmGh4c0LJ+hNQiC+Xnh0SG6CwhF9pJ
	Egv8YegBU00/n9Dg==
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
Message-ID: <20250707083034.VXPTwRh2@linutronix.de>
References: <20250703181018.580833-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250703181018.580833-1-yeoreum.yun@arm.com>

On 2025-07-03 19:10:18 [+0100], Yeoreum Yun wrote:
> Below report is from Yunseong Kim using DEPT:

what is DEPT?

Sebastian

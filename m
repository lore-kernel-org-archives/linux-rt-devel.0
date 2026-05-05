Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8292556E
	for <linux-rt-devel@lists.linux.dev>; Tue,  5 May 2026 06:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777963603; cv=none; b=DTlx7kRgYztpcnSkKaUGXMEWrgBNMVX2/RTiImMCQ6WGxuBd67rk510Gjn6fpPCdZo8kw0XqcfcuQgZtnGvf+02Nm4qfPONjT/27OwIXIPYRmXFkevQyqGCeTv6lZ+eJB057qqqfgkA+5MgLMNzYOHCs/SBM4OPFM2u64QOq5v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777963603; c=relaxed/simple;
	bh=oCrm07LXoVgf7pK92HvZ5vO6gFzJ3GIf8b2MU8f9jlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SzB1Puhbq5nSaZQtlh/vczmgkzXuKlf5aH5hogsM5b+FUhdDwtVpSqkE9Tmk92ZY//YoRji1tZmASAHuQWqb+Uh7+HDCHYsXggaVRX5BRVqZMQbAWsLXMTixKix1CqU5HutQ9tkxQXmBDihGsYDRY4FhjQAFzPYjnn6XyPvsHVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bBdVmsWX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CxO6JbTs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bBdVmsWX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CxO6JbTs"
Date: Tue, 5 May 2026 08:46:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777963599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCA4mAv1kgwl+6PsK61T28nBD8diqlLZ+nburn6SHc0=;
	b=bBdVmsWXMi041ndlHaGu+zncQEKZ12mMDEcmBfv95Efxz6aSEFDYXDJR4WD/owTp1tjzZx
	o+UT/Tdr8Tr5prep6T+k03ZOrd6TKoCelsaNbYvkYMUrOW1NGvB/6+/fpYGio7ahrWAnIA
	E8bsrVmBn3DFckns+sa51ZpFCuriC+ab6UC215vE6R/nnWt8fHB3VyzjeB+WfKlDvOKPjF
	VO8Rp6tGC2NVwsiLbfJoEGpng1AbHXIl9zJPlkBQ5U6sBZPxHFx2bxKBkwUX6UazvKuTtS
	NYHFtE9quRHGG+pHrvP4U5cTR0iCWggxbHm+3Nmkj0r30JO+oSpzv1+eQeRbYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777963599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aCA4mAv1kgwl+6PsK61T28nBD8diqlLZ+nburn6SHc0=;
	b=CxO6JbTsHVe/V738JN3Lscz0HhIvsZjndxK9M0cYf2t4BQRq58wtIATq05ru9vOkaU/C/l
	zKQP6l8K2L8mFUCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc: clrkwllms@kernel.org, rostedt@goodmis.org, david@kernel.org,
	akpm@linux-foundation.org, vbabka@kernel.org, willy@infradead.org,
	ljs@kernel.org, max.kellermann@ionos.com,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] PREEMPT_RT: Fix the typo in the comment for
 kunmap_atomic()
Message-ID: <20260505064638.EIl3VHAo@linutronix.de>
References: <20260505021125.1941691-1-zhouzhouyi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505021125.1941691-1-zhouzhouyi@gmail.com>

On 2026-05-05 02:11:25 [+0000], Zhouyi Zhou wrote:
> Replace `PREEMP_RT` with `PREEMPT_RT` in the header comment to
> match the correct kernel configuration name.
> 
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

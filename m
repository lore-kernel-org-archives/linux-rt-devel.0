Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F021DC05F;
	Thu, 14 Nov 2024 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579700; cv=none; b=FmsGMfTx4uTqPddME+R8AcKstTwEY5/cjH5kb+2QcbMC/rBKnCnFXnBIHuYdDHpigYfLl7QhJa80U5Uo86Z/BHOXvSiy/JRC2We8Ek5Jo48KIEEBtywqem7GXjbwkvQYpr6fUgXztK59ceUG2YwxYfMHQF648E4aCfwnVADKzH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579700; c=relaxed/simple;
	bh=TEoZNOCdI7xNZCkq1Y3DANMX7RzVOnudyVhuh0ii8i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emESROBbjhCeAzc7L+3paYm/PmxnBiEVXvWnET9j4B1tcTIfbeAMc2DmAlaBzWjvsKfSc03oKzCZNdLUqWIbqgIBOz6mmJaJEctioJpAwDhmzmc0HeniGEfmW9OkAmpw2ubIfrcPSNH8tzDsMkZJ1h2MRioeoXKjSW56JPcAN98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jTI42C+s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kDzQ3aVb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jTI42C+s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kDzQ3aVb"
Date: Thu, 14 Nov 2024 11:21:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731579697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TEoZNOCdI7xNZCkq1Y3DANMX7RzVOnudyVhuh0ii8i0=;
	b=jTI42C+sqxH+U4RZLpRZWPExmJKPrCbbacd6rnECOG7E9Mtv4Rm0+fhep/G05wT29RRQw7
	6msRNjut7KcEvMFvhy5zcGlnG9X226hGJSDXBgSkInqNlT9xGXtx5kvWygF9NZBeb5alk7
	2IJdNh9+rt4ype9skt/bPyjOaHTe4WozboL+ogf/hZtNp5+4/4+TBsQeB2oy3sp0dyxnXt
	5eimBc2LXO47r1UkX5M2AxvNSeyqCBtPq5dmRRMr+X7bTc3YrNwBPFdz1VsHg3EmlywZb4
	x/KUEGm4pY3BX/ZVhMl/QpizcIgRcg0cmXJz9D1Tq+dgdJu6bgJMaklXz9OK+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731579697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TEoZNOCdI7xNZCkq1Y3DANMX7RzVOnudyVhuh0ii8i0=;
	b=kDzQ3aVb4GVo/+ptSTPNFLn+oXo6Fi7B7F0WiQpLNDr9+CiLsgOv/oKmWv9mFRtXlxiMiq
	ZWbi0Y0nrxu5COCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, Guo Ren <guoren@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] LoongArch: Reduce min_delta for the arch clockevent
 device
Message-ID: <20241114102136.X-knc36J@linutronix.de>
References: <20241108091545.4182229-1-chenhuacai@loongson.cn>
 <20241108091545.4182229-2-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241108091545.4182229-2-chenhuacai@loongson.cn>

On 2024-11-08 17:15:43 [+0800], Huacai Chen wrote:
> Now the min_delta is 0x600 (1536) for LoongArch's constant clockevent
> device. For a 100MHz hardware timer this means ~15us. This is a little
> big, especially for PREEMPT_RT enabled kernels. So reduce it to 1000
> (we don't want too small values to affect performance).

So this reduces it to 10us. Is anything lower than that bad performance
wise?

> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Sebastian

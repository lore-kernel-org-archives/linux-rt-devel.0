Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19195566A;
	Thu, 14 Nov 2024 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731595403; cv=none; b=Jmy7fCTWHMcbW87ep5OrN9MfqXuoJXvKXMB8fJoRZKQvtPrsPDvn9mgs5SmvjT1a1K0+JNCI2C9qnp5UJHnB86cyP+fi3aSiMHOUSVVgsL3eOSRuOutMyNCAfEm6AwGvlIizjfVpamz+AWUOWACNhx96a6k35SBJo/OHhmJkpuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731595403; c=relaxed/simple;
	bh=b6kWf9cYtlJIUgG9DFXxGeUKCKiMGwyX3lpYWJ0d3dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcY5FMciG1sEqTgok6xxM6/ArCd9p4i/QIXybvXpP8z65PJau8PEkIBJXx61JMzOWE7sy4JnGETzl/JenqYwb+PrCBwf6dpPl8L3G6A5xih2UkpEO5L2PJVTBOlL1rc8jin+4h0OjR4fvkImwr2H9NmlDrCOXZIeBZLR8b37Z6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrysDd0U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrysDd0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD97C4CECD;
	Thu, 14 Nov 2024 14:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731595402;
	bh=b6kWf9cYtlJIUgG9DFXxGeUKCKiMGwyX3lpYWJ0d3dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lrysDd0Utmp638DNgzcrS2JTtGIUmvFc9tIbO26XYFS+P+lzG2pzjXrO9LVRi6H0V
	 etprv2mezDAURqsh2ytixH/2vjBVaGYeEgl4kb+J1ta25tozwAhfYpSootgKlvr565
	 H3zW6CsZ2/6oj0f7H++asIk0CDDwgMybtkGppStu2GNzlkWF/6QIyIjHuYuZ/P1iF4
	 JumGSevHEEoI/U4ZTK4/vnjG/cCNv6qS3F76IpB2yftuhly0jIni1d31aBBTKDcGdw
	 YCIapasA0wGJCxeVRZCtV40jN1vP0uxIdhQS45CThCCeUuf+F6DYzyJHUAPPBIjp71
	 +vPJnv0ud9G6Q==
Date: Thu, 14 Nov 2024 08:43:21 -0600
From: Clark Williams <clrkwllms@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, Guo Ren <guoren@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] LoongArch: Allow to enable PREEMPT_RT
Message-ID: <ZzYMie7ktV8ByaQF@demetrius>
References: <20241108091545.4182229-1-chenhuacai@loongson.cn>
 <20241108091545.4182229-4-chenhuacai@loongson.cn>
 <20241114103111.5W5ZY0D4@linutronix.de>
 <CAAhV-H72YSNBGutYPOVi=S7nwLb6YOiQOFqnimAp=9D0wAJc3g@mail.gmail.com>
 <20241114111409.LWKp5YEg@linutronix.de>
 <CAAhV-H4ecBZsV+9SxLZ-JFiUK=b3tMqkLZe0djac0_390==MMw@mail.gmail.com>
 <20241114113018.Ilo9ZsQo@linutronix.de>
 <CAAhV-H4jDNG8nsW30U9zE1-c6dHwy2fSjy5hkZhpWWu3=og64A@mail.gmail.com>
 <20241114132956.wafcHvaB@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114132956.wafcHvaB@linutronix.de>

On Thu, Nov 14, 2024 at 02:29:56PM +0100, Sebastian Andrzej Siewior wrote:
> 
> Ach okay. So the pure read on the slow bus causes a delay because the
> CPU is stalled. That is not limited to chrony but should also have an
> affect if the user uses hwclock to read/ write the time.
> 
> Sebastian
> 

We see similar problems with chronyd accessing the RTC on aarch64
systems that use UEFI. Accessing anything via the EFI Runtime is very
slow. Probably going to turn off 'rtcsync' in chronyd when running
low-latency workloads. 

Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790

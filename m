Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792614492;
	b=brxLYMJiMIoKOM9zcRJ32av6FHkFr4wJUl2UIv7ouTaO0rXgsd9sz4VJYmzG6VnVcvfV
	 sfWu+EHu1UUXrofAkFD/QaNmK2HOAPAFwnLMxVVztoVmyOr+6ZDh+KyPq1T2/1K1lotCW
	 9ULWSfyyfNdKUk1NVMRxRdKw846TKNsJtazsXGLscAfKpU+G5jZyBzqM7mrXoSIRvSiD7
	 EEPhV1AgwRupc2+MrA0zXstTkhRDVKqxc0xT8Wl8sCfwxfFNGaDzmDnPrPMfqYAiL2wKo
	 WtS6cVqR4RfeMPqVOl2NXPTilwRfo/6YuB5ZW3SLE4llD1fxHkuCzWPkxNbiQEPp4Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792614492;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VSHl/+6gsuyQcoPA3hVHSxV2FoDIUKsJ5OqZcbF+mxY=;
	b=fUlyg9WCX/zQhblD9LPf5/fmvzuCLVpZKWQrMKa5PHuraIYCiZxmC8+gBVKdqtZI+UPb
	 6X30HowiEDbuYkUQmOfoJmaw6S4Poi6AEqjD+XDyEr5VrbdMenI6p7N6lYKvsob3UrXq0
	 CIRG+t4aufhpqNYOiYP0j4iArdBLpML574AW66c7jVmkPpBmfI0c4dtA5I1VO1pUdiaMe
	 VQxMItKkjeIlIucHJiAXdmgOPfwVDTfDfk8eFmHbaN+c+/4wphL4KkqHdmSMC7ff6Xc3O
	 FIiMkBiNcsaaGOAEm2kWOAtVFjl4cDFS8i4HxF1NPySXzVqLco65WrMOIjza+3MWYZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kB7qldVF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14A8606A319
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 20:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kB7qldVF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447A61F000C1;
	Wed, 21 Oct 2026 20:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792614491;
	bh=VSHl/+6gsuyQcoPA3hVHSxV2FoDIUKsJ5OqZcbF+mxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kB7qldVFMeStD7ZsvOlqwKDLG0shcc6Trfdigc3VICy9Butb1yFJ186tWvXskpy4Z
	 wIJsUfGcI+jpJaS7tKfpcFzWJPoDX21xtmMSNqiKVYE7CptbTaKBdRxaFZNDTwOLMe
	 fTu5zcp+EdqU6+eaf//vVYBXgjfivsRle8sDYLNFCNPdDJ1T/XcghRBEjIOOWHT62D
	 +iGu4Gw+JZ/MgJg5ADmn9b34psDOe41gMsgApxFgE2kTpZeHSodtIK+UMdDvc4o8VE
	 txLcc4grilwIV+jNJ6ngej1pT80fqN3dk/19pNBfhxu2T21kgLYlW/Q00PHn1yJbO2
	 APmEUNcU4Colw==
Date: Wed, 21 Oct 2026 15:28:10 -0500
From: Clark Williams <clrkwllms@kernel.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 6.6-rt 0/5] net: Backport backlog-NAPI threads to resolve
 PREEMPT_RT softirq warning in SMP flush
Message-ID: <atkgWnLibc_213ES@demetrius>
References: <cover.1792345413.git.wen.yang@linux.dev>
 <atYZLK0gmG8vRHxG@demetrius>
 <b957b12e-f272-4dbf-a308-c6b61bcb3d66@linux.dev>
 <atZWIBciePyeMnWa@demetrius>
 <atZmgh0uq6sTdWTc@demetrius>
 <7f5046fd-f38e-4966-a616-0c8d95833eed@linux.dev>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f5046fd-f38e-4966-a616-0c8d95833eed@linux.dev>

On Thu, Oct 22, 2026 at 12:30:22AM +0800, Wen Yang wrote:
> 
> 
> On 10/20/26 02:50, Clark Williams wrote:
> > On Mon, Oct 19, 2026 at 12:40:48PM -0500, Clark Williams wrote:
> > > Meh, 15 patches doesn't suck. I'll try and get to that tonight or
> > > tomorrow and see if we can have both v6.6-rt-next and v6.1-rt-next
> > > soaking.
> > > 
> > > Clark
> > > -- 
> > 
> > Wen,
> > 
> > I was reading back through the threads and the previous series and am
> > confused as to whether your 15-patch series has all the RPS code that's
> > required. I seem to recall Sebastian indicating that the original
> > v6.1-rt patchset needed some extra RPS bits?
> > 
> > Clark
> > 
> 
> Hi Clark,
> 
> Thanks for checking, and sorry for confusion.
> 
> My understanding is that Sebastian's comment referred to the existing
> RT defer_work workaround, which covers deferred freeing but not RPS.
> 
> After rechecking against the upstream code, I haven't found an additional
> RPS prerequisite needed for this series.
> 
> Sebastian, could you please check whether this addresses your earlier
> concern about RPS coverage? I'd appreciate any pointers to prerequisites
> I may have missed.
> 
> Thanks,
> Wen

No worries, my natural state is confusion :)

I've applied your 15 patch series and built/smoke-tested it. I'll wait
for Sebastian to comment and then I'll push what I have up to
v6.1-rt-next.

Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790

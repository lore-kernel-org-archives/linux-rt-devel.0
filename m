Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792791115;
	b=YbgsxfUGbYFNE02s+nKrEBzWCapxpW+IfdXtNuvAWfIbh1cDbC7SRCjdj2BY1ICsoMA6
	 Bwlq+aSnDZaUO1ENHVUAhkrOQkwZilXAKZL/GrxmjSI4y9NkxHbJWhL8E7rJ8XsvGntw4
	 LbERFZX6Wti5DUvNbvMhG7882ypxJEiCIuwvJ+sOHa2sFMl3yWt3dMaqyZ6d+1/QlpnQN
	 BHXkjLIa1vClOXRvtoejpER+fxEwmuJfW3dk2+pe4LwyPIFt+BdzQy49qWAXmc48mGLVS
	 HVxuVnzwt0GwlqrytKsIsU4t66KKcxdjQ4e5zpICgDHYSXvoWa3H6Kh+SbD9T0ZiM+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792791115;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=C35oPVKloVYdNLD5sVgcwxBecgSs0pgBZuAOJibDvI4=;
	b=B3yICPG0LldK4BAM2WjUxwQnGuQycW+QXQWSuhk2pdyLKLueKEpweID51XaskjVNSUuu
	 Q4qvQftIBvzWNyyqXwi3g8CJ1Y0t7I5+3EFbYVCUeRD3C4GuAJ+qaq0Ey1CTSRpOrgHav
	 LxXgeJyz0PCHtNdgXPev7tMkJBvZotLXeliLlkm45z+2uJ0qeRTsWdjiP7xa1l/K4DiUn
	 g5y1ichhisatWN7wnk8XJJvrhQpH5PeF40EHhFnLA8a9c6FFTuwzNlc5APO0E6xuyKIpv
	 RvRlruBeGejm3+VmpqZG1Ne7+JkG41hRVvj4zvPBGIrcYVtRW7xv92pPD00ND84c/fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H7VCKA6v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496D9606A31A
	for <linux-rt-devel@lists.linux.dev>; Fri, 23 Oct 2026 21:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H7VCKA6v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97371F01825;
	Fri, 23 Oct 2026 21:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792791114;
	bh=C35oPVKloVYdNLD5sVgcwxBecgSs0pgBZuAOJibDvI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H7VCKA6v6t9AqxnX6kgyP6r7SxS8Myw1Ir3YQB0x72QXtVtI/zRDHz5HHWjjhnlXp
	 RKWnVNLx8u+qzJG/p4B4gyG4O5PKbhvitDdnZplWC4BU+sAMfi6khn73ZJMhyQUaIB
	 C9zVt0ek+GDyoWCDjibJG0gtb6k9LL7NvhbqIvcGZX9FncPbibRovzRpO2k8226+Wx
	 Ohv2Xd60/FNKrbevBkGXRFOviQtddh8Eo7ZE9o+GA0saDh4F0gakTayI1w1aCkcpdK
	 uuC38wsDz7PyAO4NM2TMnyzwe7dCEQGwOa/3qTK88HvO98st7rL0I5ZrR3AhlImJDO
	 bcqIQC45ZWWBg==
Date: Fri, 23 Oct 2026 16:31:17 -0500
From: Clark Williams <clrkwllms@kernel.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v6.1-rt 00/15] net: Backport backlog-NAPI threads to
 resolve PREEMPT_RT softirq warning in SMP flush
Message-ID: <atvSJV_L6wHpYLGu@demetrius>
References: <cover.1791912669.git.wen.yang@linux.dev>
 <20261014150853.f8I2fNx0@linutronix.de>
 <atDWZDywit4ilzJ8@demetrius>
 <20261015133811.PtBdJYyx@linutronix.de>
 <2c3a8c0f-3820-4531-b179-b2656a7d3c7e@linux.dev>
 <atJ0axhl3AHQIDsa@demetrius>
 <20261022092536.HVMUjSuS@linutronix.de>
 <058f0fd4-ed91-4e9b-84db-90e0a3aa5d19@linux.dev>
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
In-Reply-To: <058f0fd4-ed91-4e9b-84db-90e0a3aa5d19@linux.dev>

On Sat, Oct 24, 2026 at 01:42:22AM +0800, Wen Yang wrote:
> 
> 
> On 10/22/26 17:25, Sebastian Andrzej Siewior wrote:
> > On 2026-10-16 14:00:59 [-0500], Clark Williams wrote:
> > > Perfect. I expect you'll have a small series for v6.6-rt and then a
> > > pretty large one for v6.1-rt.
> > > 
> > > Thanks Wen, I'll be ready to apply/test when you send it.
> > 
> > "[PATCH 03/15] net: napi_schedule_rps() cleanup" has
> > 
> > | commit 8fcb76b934daff12cde76adeab3d502eeb0734b1 upstream.
> > 
> > in the middle of the commit message.
> > 
> > "[PATCH 14/15] net: Allow to use SMP threads for backlog NAPI." has only
> > context related changes.
> > 
> > I don't see any SMP-function calls with the series applied. This looks
> > complete to me.
> > 
> > > Clark
> > 
> > Sebastian
> 
> Hi Sebastian, hi Clark,
> 
> Thanks for checking and confirming the RPS coverage.
> 
> Clark, would you mind moving the upstream commit reference in patch 03
> to the beginning of the commit message when applying the series? This
> would be a message-only correction; the code is unchanged.
> 
> I'm happy to resend if you would prefer an updated series.
> 

Hi Wen,

Yes, Please resend an updated series with the reference(s) the way you want
them. I'll pull them in, push up up to -next with -rc2 (just to make sure
I didn't miss anything) and then go ahead and release it.

Clark
-- 
The United States Coast Guard
Ruining Natural Selection since 1790

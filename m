Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792955828;
	b=xr2+Edm11qp3Qf29KEkaJJCiSDudghmnNEmL9QEGKEQLDKD0ikcBIK1oP35KMoIiuH5v
	 4Ewg/jRMg0JsrbIhX1WE4XNKHP2AhsTaEg9wMdYQi4/IHLj0zD8d42w0mHmMyyy/VNDe7
	 H+9hUgV7hVf9jl4kp3+GCfM4C/rk9gFRW5kiJgN96sN/IB1dIU0LJavhMrkLQs98kuMlh
	 D+JcLzAj021d1looVFPe4ZJrYOejlGZe/XCdkEAbGKclHGSsOEJNtckKLAbDmdNUGRWCo
	 GuM9EZ8KtDnzhcpXtVY4IixnzHpb+peCVUA3l5131RgsK8PgXG1UmTsUTjedRHs2mcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792955828;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RR2EMM+rjuO0FNuw5ZlUNaVxsn9wPfqdK7GV5CML76o=;
	b=bw7d3zJ9rgNjdeM0oYsPd509HmtoFViPF5anxkCgRmExFPFBna/cSz4JcpA74WlzwgaJ
	 R1chXAzXZwv75N9CXV/qZqPgVJeN2S3D/SYfJMBL8tO02AgS4JANk8qYw43WBh+30p09H
	 rmqzY1oGuE3yNlzwGnEFSZGhBF8l/+EtYxeTx2uHAelYte3tNxVEvmgzye7WdD+vHw7/D
	 Z2TDzRX3aFCml5bX5dQ6JdHKEebDu0BPARlglK/sOgYshoRJda/3Ej2eBRgY/CjLRH9oj
	 hsZnFp96tNgq/X/ZgCp52gfYU3P7nB2uvX85bw/wh6hru9taQMxLpgOYUnkfF0eCr+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kSEBf+tm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2F9606A31E
	for <linux-rt-devel@lists.linux.dev>; Sun, 25 Oct 2026 19:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kSEBf+tm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03821F01280;
	Sun, 25 Oct 2026 19:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792955827;
	bh=RR2EMM+rjuO0FNuw5ZlUNaVxsn9wPfqdK7GV5CML76o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kSEBf+tmGxLjA4DLmJ3S+tp8sNCmVCO2NyHz+zQqMPMv/8ohIJVYytIrcFBo8/7ZK
	 FaQF4dWZ4Pinh4DE9+fb/8L8/wc3KODRd4cGgLG9KHM+mrbMZkqaDFocqPFbCefyJ4
	 4iodHzf68nyWuUUwRnbojX/2mWr7b6W8jS8/xRaXRyknSTdz3i0Ifp/wzUzR6aXVoX
	 vMl6GMY1ADvQmEWVTTYaCAKqtyF2lBENC0NX9/8JeLhxJSNZeonjedt2DAkPqddNps
	 6oWRh/AAnPj+CAbupPdHzfKm6+j2DpNQ1Ebxk2XmmecpEo0YtYNw3ZSiF5TxZAY0CN
	 XTmeX9lcujlgQ==
Date: Sun, 25 Oct 2026 14:17:06 -0500
From: Clark Williams <clrkwllms@kernel.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 6.6-rt 0/5] net: Backport backlog-NAPI threads to resolve
 PREEMPT_RT softirq warning in SMP flush
Message-ID: <at5Vsl76kHD__sqa@demetrius>
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

Wen,

I just released v6.6.159-rt82, which is the five patch series, this time
with my SoB attached :).

BTW, I just pushed v6.1.190-rt71-rc1 up to v6.1-rt-next. Please check
that it's the correct 15-patch series.

Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790

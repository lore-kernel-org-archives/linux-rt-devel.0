Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8402FE582
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 May 2026 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779257965; cv=none; b=YTlfv5/A8BKxF/EuzkHjaLO/JZTWqSeTtc41iutgFwDpq9Z5dq3Yxp34Wgn8Ztp3X25BJtn4CurA2Y103hU5pCRJ+2o4q1sSPhKzrlnYivAgrd+nO6iv57oSTqbFatoq/E/noXnGP5+s3UZYa7XUGkiHNuMSmuQn091lMBJ4Oj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779257965; c=relaxed/simple;
	bh=y+oQO7RLNuJDf4qUq9ZXkKu2kJNnmahDIWX+FfPHgIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bymX8LawOfJeXv4p/NFCqVzCxDeq8IBEb3H8TiwpV+miHrVZhLIsk1c95SSrV521bIvpT8ri6DykDB7MzAoHu+ohgHi9EcOG+La/J/RgSHhQhqefNUlmQqZnlXD3MHUJy0O7CC51SsXROI+X3KcOJ3mfz4y/Wf2viN+amANPtiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P6+oqLlL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m4pxxi/4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P6+oqLlL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m4pxxi/4"
Date: Wed, 20 May 2026 08:19:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779257962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+oQO7RLNuJDf4qUq9ZXkKu2kJNnmahDIWX+FfPHgIE=;
	b=P6+oqLlL4bnQTSu2n0zKK01Ew7ScsATyYZvIYVSe7ttHWoUMDq8DN68cf29PQU8Dq5HIiI
	lpSMQlDfJsnMzzx0r14lx9+E5PN8eqKBM3Kn3SfaSrLMJ6tVurPphfqFWW5s8Hvc1cBZfB
	U2KQVsG9AKP1zrqc6C3guqgeHrz+ncPTf14QOWQbwTbrSl3RnZJSLszx/+LCXgZaPendB2
	AuUoBugOIKV4ZbtALNiu8WcYxlvIn23LgeN0fjb/uYDcToCfPBV6vt9G1AGJqMB1qIp0ni
	eZSIx0RYgIH0TGCn5LiuN74oVABVWLe9v8FukHDFoWfGE/NtO0tfjMuS2WdwUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779257962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+oQO7RLNuJDf4qUq9ZXkKu2kJNnmahDIWX+FfPHgIE=;
	b=m4pxxi/41Ii8jM6hXoGv89KCZT+zmgpcacIXgXgpsf5uav74mKO2geuwbKby8RWX+wkAms
	orxgFruU8Al/CoAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <longman@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] arm64/entry: Don't disable preemption in
 debug_exception_enter() with RT kernel
Message-ID: <20260520061920.XCqBHe0x@linutronix.de>
References: <20260519222524.886454-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260519222524.886454-1-longman@redhat.com>

On 2026-05-19 18:25:24 [-0400], Waiman Long wrote:
> Commit d8bb6718c4db ("arm64: Make debug exception handlers visible from
> RCU") introduces debug_exception_enter() and debug_exception_exit()
> where preemption is explicitly disabled. With a PREEMPT_RT debug kernel,
> the following bug report can happen.
=E2=80=A6

What kernel is this? I have backport (which is being tested) for v6.6
and v6.12, the patches are from v6.17-rc1.

Sebastian

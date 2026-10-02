Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936FB463B86
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 Oct 2026 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790978059; cv=none; b=e3fMqcB38Gv/dK61sx/Tf2S2bigtKdLSeMXXRfsToJkNGv6Mx2h77nDPY1K70UA1H++kghal2ZMddltfoShcgaZ3iWflh7OCgTXMOyTrJuGsN6V8/rwI8CPuxqBei+n97c76fgQ6MaqPez0R4Srd3EUvf9GxK3QP6E9VYPQFjO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790978059; c=relaxed/simple;
	bh=/zn06wt5whvMHZjgDBvZfLc4hMOido8Tkmdk0Z14s/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8w1UKkb8J0w0WuvHojqmFhiV+9PduOD7T7Ai6ohkl58sdsR43wwrxG34i7JohzgC4GTwUrKbmfoZOrSnnkHDg7nRuQlDhcHioF6akEObTVYNNHaOcwU13pDV3rgx99BmJQ1y7TqWTjAJKj3RSWGhpc5Kr9ESY0yV2fwnHOSLlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V1Zg0f2a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sTo5iCqo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V1Zg0f2a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sTo5iCqo"
Date: Fri, 2 Oct 2026 23:54:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790978054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w+D7DxGAU7JYy5hIt3woWGy4190o/Tc2Pglh2vrdhz4=;
	b=V1Zg0f2a7pm2pFAipBTtlLBEVdJWvHuyUKfxRmuHKMdMKuRtx1zRyBYLcAYYs37hFZgx6G
	bK8GzBc0iCzdAg6UvTud7IfW3xUxA1Ql/Hkpn6riP17QBbzXupbnBewuPn1/M0R2PXvX9D
	vzdZa47ThK+b5HVZ3gAUCoNnqogJ95ZB27A3X6imsShY9On9WAvv2fHfIwAeNDzWy+so8r
	7t4uGyY/JtFcfj5OWUFod4P5Ic2gp4RRMwV1oAkVvFWxOF5E5koZqGbptBbZlYyZQhIdh2
	DTx5iLGmqqLkf4qy5LYgjb6f/K23HVpu2gVMiq6eDRm1I8BWwHJFF+AhcVAC6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790978054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w+D7DxGAU7JYy5hIt3woWGy4190o/Tc2Pglh2vrdhz4=;
	b=sTo5iCqoxr5SLVCs1SmuPwz63hCWdbe3YnUbFhWn7uqbpqPJI3VsSeqbqPqk+klu0WZERA
	SCthXSWOrMLh2vCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Nam Cao <namcao@linutronix.de>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v5] af_unix: Do not wait for garbage collector
 in sendmsg()
Message-ID: <20261002215412.lUoSB2XU@linutronix.de>
References: <20260930162457.4ajVJ-Qa@linutronix.de>
 <20261002125357.200a5aeb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002125357.200a5aeb@kernel.org>

On 2026-10-02 12:53:57 [-0700], Jakub Kicinski wrote:
> On Wed, 30 Sep 2026 18:24:57 +0200 Sebastian Andrzej Siewior wrote:
> > From: Nam Cao <namcao@linutronix.de>
> 
> This looks effectively identical to v4. I'll put it into 'Needs ACK'.
> If Kuniyuki is unconvinced please do not repost this again.

basically the same, yes. I did try to explain why that flush does not
improve things. Also I added my notes (as a reply to the patch) where
the bad boy consumes a lot of memory and the GC+flush do not help. This
looks like current limits are too high. I am also not sure if the memory
account for sockets in this case works as expected.

Sebastian

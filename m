Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3B3CFF4A
	for <linux-rt-devel@lists.linux.dev>; Thu, 15 Oct 2026 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071495; cv=none; b=c0n0IoAFFWcDEhwqNAb6d14fWUMMuF2gID/hH7vuCmAQRCR7+vwZgxu7aGfdapJ/8VkBJBcUXdbXgRheAfAYX2ZNMIIbLA2yIBB4RVbRsD3+uOwnf4TpPZ9kDHFu/aSHUXDyH6L9arGAbCt9C8du0sFiRdL1lPe9zryvAfVnKEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071495; c=relaxed/simple;
	bh=ATIZRHZVFDVK3VstAUaPTZm0n0/+n2n+YKujI1rdqOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3dzETTBIOU6SuYzBEFVk9tw21Z5iJFfec0sDu0fPuUG7G519pApOdvKbAdXdK0EGuQUpnk0cty9LPBN7b55jwUeG0fimJ/af8p2/CVoVNBVO5gU3sOoAdd1k797LT4z+ITlZBVVWTA04JoY/nIVGO1lLHI+jxYLUbSY9D2x6ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V2CcGxo2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q/ufk1Wm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V2CcGxo2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q/ufk1Wm"
Date: Thu, 15 Oct 2026 15:38:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792071492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ATIZRHZVFDVK3VstAUaPTZm0n0/+n2n+YKujI1rdqOA=;
	b=V2CcGxo24B89gNNC5gh61fuXZk+X55EY5cFGp49JNH5T8Tr1mI2DOc4sJ26uQ9BlrtYypz
	vn2QdjnHV+RzZFGh1tcHr5X/i1JpnfEvsK9oiAXtiVcvQba0o4NtkNN1agFT4Tmuxdi3d3
	vNFVxyH2FUcLV/IaReWn+YUQa4AniXwQ61uJNOmQRupdUubQ6Q2/+Hlq1jiHd13nFBZswP
	UUNcfF9dDXaZqZHrym6H3RkZEei55Funxp05eKCebjUrKDQjg+ocdpQ6YfsNbEfAySzDwZ
	5Af3YDRuZP3tDDRr3jW/Uy60OvbuMl7YxgeYBwXyHxYHf83fCZFH5ft+zGZfHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792071492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ATIZRHZVFDVK3VstAUaPTZm0n0/+n2n+YKujI1rdqOA=;
	b=Q/ufk1WmXf9dyc5N8lxGIKkcW6oZpGxERUUvwDF2arx7stBF/gGqH+6vEeUf1yMAiw0Y0S
	YnhOTgmhF5KhOqBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Clark Williams <clrkwllms@kernel.org>
Cc: wen.yang@linux.dev, Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v6.1-rt 00/15] net: Backport backlog-NAPI threads to
 resolve PREEMPT_RT softirq warning in SMP flush
Message-ID: <20261015133811.PtBdJYyx@linutronix.de>
References: <cover.1791912669.git.wen.yang@linux.dev>
 <20261014150853.f8I2fNx0@linutronix.de>
 <atDWZDywit4ilzJ8@demetrius>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <atDWZDywit4ilzJ8@demetrius>

- NET + proper list

On 2026-10-15 08:34:28 [-0500], Clark Williams wrote:
> I don't have a fundamental objection to the backport and agree we should
> do v6.6-rt first, then move that back to v6.1-rt.

Okay.

> So it sounds like we need to pull in the RPS code first?

Yes. Wen, do you mind preparing a series for v6.6-RT?

> Clark

Sebastian

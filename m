Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFA64BB815
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Sep 2026 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789639479; cv=none; b=cbMeHpZUUFkxPryX33UfA9AdHVISVoxDhLtlKXk/mQZgnoK2dKdli+pjBlxRDeGcVcPubqjQmEQAb6VPaqm2C2KFeZ5ku0rJHAAwhFRuWWBe4Nr/JizExoIo4V9FW9mEVK/3aARr2jmnTo3/Jse0BrrUl5dXE1Ux1wh4jIh5B0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789639479; c=relaxed/simple;
	bh=Zw0go1bY/h0Fvnvwmo4x3hJ1ZrAO60jCIR7sgEMVdwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNUpglVYErQQbs656SaUyiZxeSwC++lumGYC9J5ZMgWaoueyz+uVD0DUlnzpskLDsSlRHjioUnwt14+pEBxA2kJksTOX1Dp4XJFbQqi522MaikrkhEs+LcRlqHtRe/6/D4qVUT3wpBxwbLhxi8MXYoJNcKfP3sjKriZFdLXxWqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ASAy3Hp1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ij3Pu7oW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ASAy3Hp1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ij3Pu7oW"
Date: Thu, 17 Sep 2026 12:04:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789639469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gUoSclQfN4Mc0MDUxCK/MPlKgNaoIFGqLPM9QL3S5wM=;
	b=ASAy3Hp1LHtsIx0mSVn6CabihAkqnMmSrWieGr/JGKWUdSJzwsQqo8ZASmhkXEYLeSLCMY
	N7qhGDncA037YRWVuqQ57D9cPHojsnnti6VNH6BLX8y4eQ0X/9+RzKnQ2TGaDKQdABB0hD
	3mvqRz/4CouIIzK5BbIha/N4VrbactnScER7ixCG6ReylFcwemlHxwiyX5OI93Ld8IjpSw
	z/yKvKNUHVjyH6i6vX2ISl0NouDZHj417OoRJ3McTR0DfB+Hf+/ulPQyVnMQmc44C9a6sz
	RLXWb4nxHBrKqa6YFhcKujhCks621Jl1DdyArHSv7lDDPprfytDzA2RhcJ7H8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789639469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gUoSclQfN4Mc0MDUxCK/MPlKgNaoIFGqLPM9QL3S5wM=;
	b=Ij3Pu7oWy/cj3245y6NTY1PjubHosGSwrvK0hDjS7Iejv/SciM8DeKelAi0wnUWdWeZoCu
	IptkBDZXc/5dxWAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-gpio@vger.kernel.org, Rosen Penev <rosenp@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCHv2] gpio: mvebu: keep resume masks within the irqchip cache
Message-ID: <20260917100428.LT2ZUBVd@linutronix.de>
References: <20260915004406.115230-1-rosenp@gmail.com>
 <178963874726.7902.8784965092061133801.b4-ty@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <178963874726.7902.8784965092061133801.b4-ty@oss.qualcomm.com>

On 2026-09-17 11:52:29 [+0200], Bartosz Golaszewski wrote:
> Applied, thanks!

This looks like a hack with no explanation about the root cause.

> [1/1] gpio: mvebu: keep resume masks within the irqchip cache
>       https://git.kernel.org/brgl/c/02af7eac17bc62a72335c1fc8c4af4471654f6cc

Sebastian

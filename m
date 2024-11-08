Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CFD1D097F
	for <linux-rt-devel@lists.linux.dev>; Fri,  8 Nov 2024 07:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731050408; cv=none; b=pfYlQGaM11oSDUDs7C+WhcQloYryXSgUBlO+orlQ+HpY6Iyzhkl3rGPvA/1Bt30D6kxFSrSmTGhkPN1Io8BvXXVA9PTd4IxxVvrdQZMQELF0AxeDPCKQYdCUcGlUC5U4pOxp/iXv4wlyPJyGAjjDAqK8jATtYxZ3D6QT78vFB0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731050408; c=relaxed/simple;
	bh=gJCl7S0bqZVvnT9SEcnwOQgBUZX+WHAwroqDTxnJL+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0IB8XvrJonSIpfRgE3+kV4D4j+ISCqwnLxDz+LrN4grruewrdvUue61BPq+US/8vJb8616gsx/dDdH8ULshPP1K0D6zAWsLu9qRF3ZK9sUeSk8sUm28/Syt79nCf/GUMauW880S38m9tPRDO/cPdaVRzv+6hC0OsSERvSKXEEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AnhH4xgz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7vyL7oQg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AnhH4xgz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7vyL7oQg"
Date: Fri, 8 Nov 2024 08:20:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731050405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1XdvSNOuZouYbPrso1Npt+Pw3m9uE9gj44xGyrYmPaU=;
	b=AnhH4xgzd7yEF5ZPSICzS90838h37rRz4QvNEoDVonGelJrNlW/RX0p/tso6Ybyy8ZK6QC
	IKF14CkaWFbgOfceFNhxhb2QhxU+leLMGlXWdwDF/0kyPEtfQuvK0HJ8SP8pDeRiLN7i0O
	6NuiWXP4gK480xVWEyFSwIoUb8z0dDZn24TyC13CyacDujoIGOCXZ8UcODpau7Cm+cEyPA
	jQXSHbvAC2TaKddjxmK92ulR2sbpMF6CbgVmDlQbExPBeOzRtrnOU9jEC/Xk4FaRmCxoJz
	bDY14JRtHUwtW0FUSfBtOlSeSOJTp1eLkovJ+ePNZrxJ6tyyCistLfdYhIyvaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731050405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1XdvSNOuZouYbPrso1Npt+Pw3m9uE9gj44xGyrYmPaU=;
	b=7vyL7oQgNV/EO92EBKAOkT+kUaIUcdDXypNUcpA/+SK2vhVxhAiIFnO5XGPi/PJFsdtepA
	iw7VOGjOOY1FzNCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>,
	tglx@linutronix.de
Subject: Re: [PATCH v2 1/4] Revert "igb: Disable threaded IRQ for
 igb_msix_other"
Message-ID: <20241108072003.jJDpdq9u@linutronix.de>
References: <20241106111427.7272-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106111427.7272-1-wander@redhat.com>

On 2024-11-06 08:14:26 [-0300], Wander Lairson Costa wrote:
> This reverts commit 338c4d3902feb5be49bfda530a72c7ab860e2c9f.
> 
> Sebastian noticed the ISR indirectly acquires spin_locks, which are
> sleeping locks under PREEMPT_RT, which leads to kernel splats.
> 
> Fixes: 338c4d3902feb ("igb: Disable threaded IRQ for igb_msix_other")
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This is the only patch.

Sebastian

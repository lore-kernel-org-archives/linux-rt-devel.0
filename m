Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43379238C0A
	for <linux-rt-devel@lists.linux.dev>; Wed, 24 Jun 2026 09:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293964; cv=none; b=g3RjpqPP5rUdn8pswqXhYKmIM6iVG6SXOuauSwmFxDWUA7gAAGQrKxzIju4uuOfDtJj1gOn1rpP0T4pMVF3yCPRjTiAOceYvc/bDPyrbpJQ7RlDITRmII9j6ZMKODpH1DgR8TYOcq8rx4HwyBuitxQfu8ZvPVzNGUIy8fTLeUEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293964; c=relaxed/simple;
	bh=vOTvwVulRxzYt4pJiWJT8uuVRGIL0GjAtpSv1uilZX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2elrKTMu7JOWnZuIbprUOtMFZ1hE8KVHwwG0M0wpzyFmTpDqxuDsvNhooqrIM5QwtcCLTK7mCJsTAYseQd8ddOPg8bDr/tuMs2XwbRBj3L42shMMXO6Hw4l5UBa0YK1PSi0e0tORE2W/3CizbKGMU+59UCqWAQT7n3buUxq8UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0iS0Cxrx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8CBA0aa0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0iS0Cxrx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8CBA0aa0"
Date: Wed, 24 Jun 2026 11:39:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782293961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vOTvwVulRxzYt4pJiWJT8uuVRGIL0GjAtpSv1uilZX0=;
	b=0iS0CxrxVody7d4GXpG9RD6hlS1cHCPhfdk1bFx35M+hb9YLRQvBx4LyGDXQB+OiGHACvP
	4xZe+INU8cHsqw+DtTj6VqtHJzTNAQLvp5U7Fxpyy4369S7Rz7OxUAMQaTiLf6jyJumbe3
	V9cW8RCuTcYhcoBJPPSyKFLSVdvLpOz3rTx04yLxvvidqajTGTJWOxq/tDx+cy7IaR8Nwr
	/Er7auypB/acWL+aG++aKtZLFtzUskiCbEDBpQvv2FqD/PzXO/ul9G/qXyd1p4Ub5BrqhT
	vBGPglf1bXi7QueFLrIseei2oSUUHMtOlYqae+jDOG1qr/7LdBX7mKItquDnAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782293961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vOTvwVulRxzYt4pJiWJT8uuVRGIL0GjAtpSv1uilZX0=;
	b=8CBA0aa05Lqy0+IoShQgIyYD0FNeW7MyCbPtnaZo0/ZHtb4iCJZWWAwnZ0PmkUhhZwECx8
	h3AIftttXxXXeJBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	clrkwllms@kernel.org, rostedt@goodmis.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4] net: mvneta: re-enable percpu interrupt on resume
Message-ID: <20260624093920.qvtBsCMJ@linutronix.de>
References: <20260622074350.1666290-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260622074350.1666290-1-yun.zhou@windriver.com>

On 2026-06-22 15:43:50 [+0800], Yun Zhou wrote:
> On Marvell MPIC platforms (Armada 370/XP/38x), mvneta uses a percpu
=E2=80=A6
> Fix by calling on_each_cpu(mvneta_percpu_enable) in the resume path
> to unconditionally unmask the MPIC per-CPU interrupt regardless of
> pre-suspend state.
>=20
> Fixes: 12bb03b436da ("net: mvneta: Handle per-cpu interrupts")
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

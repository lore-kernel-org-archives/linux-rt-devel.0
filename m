Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092EA2F1FFC
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Feb 2026 11:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770118412; cv=none; b=rmQkCUCKJsMDdod2BVzzXjwfBzvU/wYt9x/TLv4tXC+GfHa4XCtp3eLjCqXJ2i7CgIm8pxDqgCoAoYaqOsa0nxnZRRBlqmoEu2hsr/tO2RVhqK27z84Iki2V9HX/GBrAIVXNWVOjCTwpfgfLAb4DRd6kEhVO5r3Yquxyz9LblcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770118412; c=relaxed/simple;
	bh=4WBLVKbWqynEknr1jt13Nhe7v8SGXELGO40uMwNELOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEXGmMzZQQwiFZ4Z81yhCtJ3zHQ4aNwSlXrrIE/sRhW2suAZXYn800Jd/Y+VU0ULczP/i+/5nay3YKJHvVmPJLaTrfqJrePXQyOx3WX3qGA6jrVNfF8nDHjnIZpPc3OFimj0fcJamlUpLQKTiCwMBrFuSOeUwL2DC8lrFakt08c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BbHOUQPg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VPn5padL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BbHOUQPg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VPn5padL"
Date: Tue, 3 Feb 2026 12:33:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770118409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4WBLVKbWqynEknr1jt13Nhe7v8SGXELGO40uMwNELOE=;
	b=BbHOUQPg2wIzVJbH26aPTf9wtM19mHhm8mrQ4WlAJX7E62TfaxDmQ1HfUlWVzEAAKXlU5y
	sOqOu66iMFJSrn7Si+oPulLp9vZGyb53jHGKWQ1EPBBhVxLc/DUUeWkFdLATTyV7pMaFH7
	BEAS8uKq2m6oCKWBBYFBuMP9YXiGbFEMEiagVe0AoE0Z5Sh4GBdGdZL5gAcCoi6qnDWAgg
	mEasDpRM+gNy4PQgoX0jrrxYWHn4cek/hPYQJrq9GKZf6aJrJpi4o7gKeIr3UWQREknT7N
	L0RWowGyuFQcz5tfERHyQY/g4AHV37RQk/yZGHogR5NWUZ+BohSqkXvdkq1a3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770118409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4WBLVKbWqynEknr1jt13Nhe7v8SGXELGO40uMwNELOE=;
	b=VPn5padL1hp+XEtUL9CyKS61ZYjoeeFsE/Ff3G8YYapiCaypHTqCD7OCQnakdTgbxFdU40
	eHQSEnbbI8xq0VBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas =?utf-8?Q?B=C3=B6hler?= <witcher@wiredspace.de>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] rtmutex: Introduce __cleanup() based infrastructure
Message-ID: <20260203113328.REAPqQL6@linutronix.de>
References: <20260202-rt_mutex-guard-v1-1-1c078dbeee57@wiredspace.de>
 <20260202175840.-IHSZ_Fn@linutronix.de>
 <DG4PGZN9OM5B.301RXEQEIVB7@wiredspace.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DG4PGZN9OM5B.301RXEQEIVB7@wiredspace.de>

On 2026-02-02 19:59:43 [+0100], Thomas B=C3=B6hler wrote:
> > Do you plan to have any users of this?
>=20
> No. I discovered this was "missing" while developing out-of-tree. I'm
> aware that an interface should have in-tree users, but I'm also a bit
> confused about who is using rt_mutex in-tree in the first place as it
> looks like there are only a handful of users.
>=20
> I'll make sure to do more research before I might post a v2.
>=20
> Please do tell me if this isn't going to be merged due to missing users,
> I'll drop this then. No problem, and sorry for the noise if that's the
> case. :)

if you grep for rt_mutex_unlock() you should see the users. Most of it
API which is unlikely to use it because not every lock has its matching
unlock within the scope.
The rcu user a bit "odd" so it would important to not get the compiler
to optimize it away (in case it would do such a thing).
The selftest is already complicated as well as the torture.
Most of the i2c abstracts its away so it can't use it.

This leaves us only with em28xx-i2c.c as the only possible user in-tree
if I did look right.

Sebastian

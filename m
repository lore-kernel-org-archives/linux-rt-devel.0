Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F05355F28
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Mar 2026 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772448347; cv=none; b=lo+DZXZ5gjdl6ZfJiZdLpLlEAH+Bsz5B5kiroNtTOjSaGjcZw1h+i4WswAiU1xfvzqHh0MOmw0l28dGas532ofYrydfQTE6nCiVYKLidkaFBo1LqXjzgIR+qUOSJDAcPD26H4ZiByEJXgBu4lLSVzsi94XgsbZg/+6I+mGamkRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772448347; c=relaxed/simple;
	bh=ro+0UBLQZX2CEbu06WhROWqv4zcsiUdWE9juG2o3PrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYxVMZ3tSwR5YYA2hGjq88ttrFjbq5gArPLGjsRYNJc8g33IxmUKzY3NGXVlRvWT7qHKvJGt9ut6JhWnzFZ3PiaCI8f8odAlrPnIW+UfJFVVQkxn7PK3c0hgP0LJ4qcGTRlDOjOufVhoTf2Ccv96DiFyRJx8u7qOSdYF2qBytyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LtXlbdoj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cJ9om+O8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LtXlbdoj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cJ9om+O8"
Date: Mon, 2 Mar 2026 11:45:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772448344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLZCvpYavonv5dbpKzNlHqyAwQ9wvWP05tDkSZR/dxA=;
	b=LtXlbdojtrbs0uq6Wwtk9r54gJcT1kbDZSyUNGVh3YGB8JMuBqShdlA9mQZRwP3GAlpwHx
	vYIusT2RodLYDqmlBIIUfUOIa65LsPUGCtm/AcA39nweqRHFZ5ekh8OVGGwQSjmQIcvf0S
	QN8zUWnA3T6z5pXTzql0trmro4NAwSHSHxfSlroC5auaBuWycFQJWzQBOQ5iFDaPZ0GnY1
	jA6HDvtCHiPU7IZU3LQEXvc6NSDk2h5wFtOUA0/K1HbwFS401wo3GWajNGeO00yw78cMV4
	Xhwsm/g35UZicnwzoPmbIe2Q74SVhCuI68NOO1AJVT/CzZ3Ewru9c+mwGuJShw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772448344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLZCvpYavonv5dbpKzNlHqyAwQ9wvWP05tDkSZR/dxA=;
	b=cJ9om+O8MslXiL0xXq3TaT/BciHGXg4IjBxOhYqWh+R7VAQRdwH3Obhv32bb8sPQh2Gkae
	iYC23uA+FLtTQXCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/6] ARM: move is_permission_fault() and
 is_translation_fault() to fault.h
Message-ID: <20260302104543.HGaa4mB9@linutronix.de>
References: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
 <E1vvzcc-0000000Awo6-2oph@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E1vvzcc-0000000Awo6-2oph@rmk-PC.armlinux.org.uk>

On 2026-02-27 15:19:18 [+0000], Russell King (Oracle) wrote:
> is_permission_fault() and is_translation_fault() are both conditional
> on the FSR encodings, which are dependent on LPAE. We define the
> constants in fault.h. Move these inline functions to fault.h to be
> near the FSR definitions.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

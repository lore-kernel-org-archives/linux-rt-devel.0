Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3E329AB02
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Jun 2025 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750865723; cv=none; b=rO8jpxq/F4bIUzlBvMxTxCtD6CtOx0lCe9vd1zNiGmwqkk28AshJ0pfqA3AaQPIakHsg8co6SHzXOVDMGv4+9MrEpwfHo8tt36PrBY5o0eswIf0aPh/lU/lMkzj7WMSlSi1t5fp+RN3Z0ifF2dFgK/cxMl7BiKEMPmjp72eC5cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750865723; c=relaxed/simple;
	bh=A7peNm87DC5TWGCaAQCUpCehByKhPLHY9RR8v7Wgq2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsh/38SEO8GJCahUGFlCvJfo/UZWEKb49aRxC6q/WQED4280Jd4CQQSSVJV7Ymp0X89UXTNNypVo74qPswNjsEs4UD2Pc7r85K3G+WFOE/lv8Ntsu3sJKUhvSYOtUG2fAZIebKMx1LzJ8rd9FIeKN2RYlMYTzbENMsC2d5twLSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bsq6nEfH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2glSEkW6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bsq6nEfH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2glSEkW6"
Date: Wed, 25 Jun 2025 17:35:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750865721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A7peNm87DC5TWGCaAQCUpCehByKhPLHY9RR8v7Wgq2A=;
	b=Bsq6nEfHqc19FS6upOBGBibsuS+k6GzDOdrfNqa7TeOFYX/lPbRvsPzmhSuwL024AOZR9Z
	p4nuMMAx9elVUpHL6HF75p7ejHk4w/usF+FnG+ObSFNbqDaw+H1h9RJGwqQrJfxhlRe+dz
	M1Zn3Qj8sXnkRwHmBEAF/IrIMap6Fiyb5t0p4dghkAnF40kz12QlNBzu5aoyg62DVyo7yy
	RBGy8K/0KzHT0ZTSM+nY5oHDN6WQsgfRmGrhCzTGm+5MqvaRSAjlqa12mYTUbJHanIthic
	+vFVxcoyyfzosM+MTIf2ntEyEvdUq1MhGtyM0IaR5BjNUF8VS/POolgnBXwH0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750865721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A7peNm87DC5TWGCaAQCUpCehByKhPLHY9RR8v7Wgq2A=;
	b=2glSEkW6BpBVoD5pTGsoLpd9hNX43zV8NPC6WL5qaoV8qR9wFQYEf3hTsLUM3FblbsyeiW
	KCkHkjBVFJ/4L3BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Christian Brauner <brauner@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	John Ogness <john.ogness@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
Message-ID: <20250625153519.4QpnajiI@linutronix.de>
References: <20250527090836.1290532-1-namcao@linutronix.de>
 <20250530-definieren-minze-7be7a10b4354@brauner>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250530-definieren-minze-7be7a10b4354@brauner>

On 2025-05-30 07:08:45 [+0200], Christian Brauner wrote:
> Care to review this, Frederic?

Frederic, may I summon you?

Sebastian

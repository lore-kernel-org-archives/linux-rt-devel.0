Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A34279F9
	for <linux-rt-devel@lists.linux.dev>; Tue,  1 Sep 2026 07:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247074; cv=none; b=kRmHRHmTd8DGfiDG65yR5yYVlUnq3a3m8qo/7v4GxlDxRNa6i1WPZOwk53tFKPw0rSJ/Rc+HXKV8nxglIaoLy/DIVbxgxszeCncraL5OP0FIINDm/xHGCdcGQRa+nDOx7c2O+niHe2NxXvAv4d+XXsG4U6CKX/3tfSucRGEHkfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247074; c=relaxed/simple;
	bh=aYsR4jlSpvw+sq28AnmN4VK19KR2u8+yQgAudjkCgwo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mZVoRez4D5terAh3nt32BimhcfcR4a/Zn+SLrKvXevAIjFhYy2I4ZI8sfcerSO66+qZBYByQbNbAqJvWcDDRW/eNxthhhqVnFkGdZphbIy5s5r/c+8VnE/YBNtNawaUNiH43PBpsiF/fkIryx+TL+NHmDA6xYlkLTo0swUHIW50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nXIUXcWZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dkxWMDP3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nXIUXcWZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dkxWMDP3"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788247065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aYsR4jlSpvw+sq28AnmN4VK19KR2u8+yQgAudjkCgwo=;
	b=nXIUXcWZjolppAHh1zVBFoGC4q7dKaxM7h0uTDRleQGSkMsfafrcOyjXjJTWxf+duJLn+F
	8M3YpGLBV5DzLZC5cCbhCUxy5eM0SopO0HbpQZ54pfPBMeLNn70C3FQnjE5nXq3mUh3e3a
	tug8lZ9heCOE9ttdhE3dVVBgyY3ZTXIGS1RqEsR1waclzyNz80S5bdey2CKqATseTZgct8
	/aTo+tON01enbkNyayXb3cvUF+OP+91NTVnmj7jCVbD/F4nOWe5kVa0WWyAPTZJaZo2ZOf
	mg2nlmlegYvMNFm05ow6+GmA8Kzg37o6CGKzAuPEkOuNUfOGpt1lmtYTeAho9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788247065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aYsR4jlSpvw+sq28AnmN4VK19KR2u8+yQgAudjkCgwo=;
	b=dkxWMDP39RG56vHjE/4FJvlxmSp/dQgpWXMdl2ECQU462YD9FgCiSDQApwRYCODsdsRJnE
	oDZlWd+faRK+TgAw==
To: Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net-next v4 0/1] af_unix: Fix priority inversion issue
In-Reply-To: <cover.1785824313.git.namcao@linutronix.de>
References: <cover.1785824313.git.namcao@linutronix.de>
Date: Tue, 01 Sep 2026 09:17:44 +0200
Message-ID: <871pbdbftz.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

Nam Cao <namcao@linutronix.de> writes:
> While auditing AF_UNIX sockets, I noticed that the sendmsg() code paths may
> block on the garbage collector running as workqueue. This can cause
> priority inversion and latency for real-time users.
>
> The implementation does kindly avoid blocking "sane users". However, it is
> impossible to tell whether the kernel's definition of "sane users"
> accurately describes all users out there.
>
> Digging into history and figuring out the reasons why sendmsg() needs to
> wait for garbage collector, it is determined that those reasons no longer
> apply.

I just looked at patchwork and noticed that this patch is marked as
"Changes Requested", but I'm not sure what changes are still expected.

Did I miss a question or an issue that still needs to be addressed?

Nam

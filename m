Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE5B3B992A
	for <linux-rt-devel@lists.linux.dev>; Fri, 17 Jul 2026 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270769; cv=none; b=bNr3JVCiaMlw6+SmBGJUfOANgDMZnFRODo5cVfIPqCP9grm2Q1c//0wC2c4FAlK4ifkNcovyIk5nq24QZAbCpCYN2q8cU4JU/YLFMLrJiLpxeKegyHGtPpfP94NTpBsPEX5MJBge0KFlmuTltOnavAlVh3tQqgH9w5sCe8P+jlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270769; c=relaxed/simple;
	bh=iReoHKBr9pfILDAM/HDoyCjEG1Ot1TUF1GFR20/B8Jw=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BHxykeV4zcKTkOt7BPalxgbLU4tQ4n6GEWxFttxKlvil9CNhfOKMy4tzQcjQct5MvPui7TawoGyXvdgpQZZpyRQ2be6Tk98FfBFFQ11Ye9i9htwTbe6clzdSPsO3Urvsv7MY0EMN0f0M/mLI9pyB6/PILe0Zbg10Dd5IflSXYCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UMj5nm1j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hSBOzsBW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UMj5nm1j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hSBOzsBW"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784270732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LS3Z1I3dFCQ+f9uupDJm7rIoxcI3JgUoPz0EEfVccko=;
	b=UMj5nm1jcUIi4PaVlvV/qqpnemV67E1H5LbwWWLsjXYhcjiyKGJCvk+c7IbMFPEVXVBFz6
	I7bNC7qxI21IxhE5KuQMXOMYENrD5gleYTVhpHOAsRAfAn9Qw/svViXB7basHjCvx3GCSJ
	hf64UnER73hX0PW5JjyDx0xmrOE8aKl/PVrOEIuqcBgdJbRtykV7roI2YxWOpudpRFY2nV
	9WhiMKFiWVK7ydvIKf4kavUPBtNa+E4kR4qVdffCMVf+z8rpBTGXCBJMuByP/UHTw1e+eV
	ZyRe3e9gGyj00d6A3LdNsAfJCUrMwxz5U3+H8oZWqT7Rt6aYPvaep0/RtDO1ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784270732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LS3Z1I3dFCQ+f9uupDJm7rIoxcI3JgUoPz0EEfVccko=;
	b=hSBOzsBWdxevTLS44tu0hVT2c87f4KQO0bHwRz2u3rZcTb7SEZyqUL38kvjVCjsQhnlkw4
	3MMmE6cch9CZ3wBw==
To: Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net-next v2 1/3] af_unix: Schedule the garbage collector
 at task exit
In-Reply-To: <d500ff36af658ad412e5d6f8d5665070359ef68e.1784268931.git.namcao@linutronix.de>
References: <cover.1784268931.git.namcao@linutronix.de>
 <d500ff36af658ad412e5d6f8d5665070359ef68e.1784268931.git.namcao@linutronix.de>
Date: Fri, 17 Jul 2026 08:45:30 +0200
Message-ID: <87y0faw1v9.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Nam Cao <namcao@linutronix.de> writes:
> @@ -1002,6 +1003,7 @@ void __noreturn do_exit(long code)
>  	exit_sem(tsk);
>  	exit_shm(tsk);
>  	exit_files(tsk);
> +	unix_schedule_gc(NULL); /* Must be after exit_files() */

Argh, I just realized that exit_files() is deferred to task work, so
this must be after exit_task_work().

I will send v3 in a few days, if there is no other comment.

Nam

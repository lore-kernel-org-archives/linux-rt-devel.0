Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E3F346A0A
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Jul 2026 03:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782964565; cv=none; b=lgCNIsWS9BrSFyN3U9RANc5oNNWGBoUbpaHv/IhKg4srkDAs1bSXRP6GcP/paowRH2pGgTCzXelqewyvtWmdG7MO1A6G4yQBdVVRfApwfbf7sN6k4ve3BKn0p4jgCTdaAZr0PtSn912bL1uCq4KiGas/d4xkjV8PL32IpPSYeX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782964565; c=relaxed/simple;
	bh=s9sWY3b6DZJtpaHOY3IYQlwXTPK/+k8OqmVOVhjqcVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lJ4UW0ijebJg1MHJhx/MB9OERAGhnJl57P+bZLi4Ui+aj4tC+JCOC6A5cgxNKC1HGoLpUKWbvoUT3qKUVMrm113wX6nlBope0VtGBIwCmFN4y4zi4Cj1RCUXH/4sgFtc5vY/jNdj6D1UhGpGsMejJQqGUf5QYhyveZz0hNBgJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KUNdYnSp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sDW7a4os; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KUNdYnSp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sDW7a4os"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782964562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeKbZYIUoPqATqmVp5Bu9QBztfXVewRC+ox4dLk0Gug=;
	b=KUNdYnSpDALsHG5DVCcRKSxSs2uv3e37OMLArcDcEQIcRlyE6kXq83LmCbNNffyavtvi3G
	a20yG8a2FaOzIrNgsXOe3KrZ7emC3QK59FKSl0w03rK4opgdzbqxzoGwhl0qFpKALyVOp2
	+Pnk8Esk3rQkRCHTHQQJBUtS9upltQcUM273CnS4T5Fhur67ZC+BxOmw6CZrlh8YMK8PDk
	7QWVVpNxZJ9OlzE8YfAKgOzACXELwU+PUmL82s2Ogspb294w+DqCmqnz9RN7Z1SftS9G6P
	Zmn0bOU1CoH4XorYMnN7EpzRZ/vGU1E3bUKZTBOYOxvG8xDUffQlt4KnNfOcWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782964562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeKbZYIUoPqATqmVp5Bu9QBztfXVewRC+ox4dLk0Gug=;
	b=sDW7a4osVaxO1ELi9fwoNuHQ2n5ylZsl2xgIfFMC3vE1V2ig0BOGoihipaEj2vu4jA/IgN
	cumtLCtCqkbTbgBw==
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] af_unix: Do not wait for garbage collector in
 sendmsg()
In-Reply-To: <CAAVpQUAKESwPnzZAJSsSgR_perYn+S3PbnDAexnWdeGAeGcekw@mail.gmail.com>
References: <cover.1782922354.git.namcao@linutronix.de>
 <e663a83195f3d9f6d7ad4907c37ae3e45c151062.1782922354.git.namcao@linutronix.de>
 <CAAVpQUAKESwPnzZAJSsSgR_perYn+S3PbnDAexnWdeGAeGcekw@mail.gmail.com>
Date: Thu, 02 Jul 2026 05:56:00 +0200
Message-ID: <87o6gqujsf.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kuniyuki Iwashima <kuniyu@google.com> writes:
> On Wed, Jul 1, 2026 at 9:36=E2=80=AFAM Nam Cao <namcao@linutronix.de> wro=
te:
>> Now, sendmsg() does not have to block on the garbage collector anymore,
>> because:
>>
>>   - The OOM killer issue has already been addressed by checking
>>     RLIMIT_NOFILE.
>>
>>   - The soft lockup issue is no longer relevant, because the garbage
>>     collector now runs asynchronously since commit d9f21b361333 ("af_uni=
x:
>>     Try to run GC async.")
>
> I don't think the latter is resolved.  Without blocking insane
> users, they can keep pushing sockets to the kernel work,
> which could be soft-lockup'd.

User cannot push more than RLIMIT_NOFILE before GC runs. And the GC
grabs the spin lock, clean up the present stuffs, and exit.

So user could make the GC runs again and again, but there wouldn't be
soft lockup, as the GC yields after short intervals.

Nam

Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D6A3793DE
	for <linux-rt-devel@lists.linux.dev>; Thu,  8 Oct 2026 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791498195; cv=pass; b=Oox/uBbLbAeU0FbLA6wyyH0UatL9jbOg85d+ZTTeFJF9TUUPER8iGQwSeD4/BoSzAitSr5kNcrxHDvd3Mnr32Z9bRsYkK2qWDt6AyidDfKJ4DbebkopbbbgyrL51MzDUg3HSoW6db3C9mGVJubdp9kFEAcPw4b6b365HlztZVkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791498195; c=relaxed/simple;
	bh=w+GdNA5P+DrEfgYC/fH9Ya+8/r8tR8bpwFXamzFHVWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfK9OXnsSzy/zrOAFgm91ZFSWDoZPpJopI4qqThHa0Kq+GVR8YJgyGl9rphpk+oKnq+Fbs6byP80e7/7XsLE6qWhVwGZGFoS8SrcnrqKDYpikyD+aNnwZx9IgE3gvFYj1ManNIP+2XUubhOYDawIOQWeALYb0oReC/mxAm5QwNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai; spf=pass smtp.mailfrom=nuro.ai; dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b=SHfNrbD+; arc=pass smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuro.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuro.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nuro.ai header.i=@nuro.ai header.b="SHfNrbD+"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35115b52125so4694757eec.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 08 Oct 2026 15:23:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791498193; cv=none;
        d=google.com; s=arc-20260327;
        b=Sx/cmIXw2s2cVrwSWMdZv+fs6O47DQgSE/hMH15cj0FlISxnP0Aocg6ag6karPkM2z
         reN+QSuR0GRogl7ZQTa73LQqbDQrzY/w7QFI5VzIftqx37Zk2c7my2EHbEwgg+s4Bd9p
         KnOJIPsUXlwLOK99CHXv43YO220gVa2b8HrdSNsAdynw3ff9J+ycuwBghBKKxvdIMsii
         iD3yYGkAFoW0qOvwkSgjhqdbdHIuTz3mOH+xejCcNZJAcsQYi113nTqyx0UeQo3+WXFQ
         Eest2AECODnnd9GVWO+1JBPyoFyKqKJK06rkkxxtqH92DXsI8QIZKvDVKexWx/yH8lpC
         xpuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VSHSXGo0t4Q/EUEgBQMVKzpQrM64wVJhdXCVhdhUM/Q=;
        fh=ljZdt/gg4mfvJCNQLjHTDNzPjOu5cn5Bmp6H+3KLYno=;
        b=hMM8aZQYoaTjIcP1JH0lsFMdOKtVZlUSU4xku8lz7zdsEG+KtxJ5KJ2xkl2KRXcHXI
         d1R82ZkLXfBn2KQx2eU9f4vMi5biXDO1TfhOBj5Pfgq/39VDCEri+du4XHO6EAMXnTcn
         NZHKAwvFzE49h0fU6i88mVOfqDWEn+iWcJvXMXJOJHBEzpsZfz5BJ5Hi1J9jiylpOBOG
         1FhTviOBiOWwEcZBCXoaRig+ELue2Bj9b+kPNx8RMmg5GzuXOZv3JgFI1SY912yq4ndg
         H8BJzt2CsAC0xRb5LnyYLaBgDTqLCfsNEG/UCO4FLuqREoLCA8mh8QJfU99+9lRowcwI
         TVVw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nuro.ai; s=google; t=1791498193; x=1792102993; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VSHSXGo0t4Q/EUEgBQMVKzpQrM64wVJhdXCVhdhUM/Q=;
        b=SHfNrbD+0KPYXraV/HKKQ1KI8yiQqcWd3UNZqphI8YhQrOIdkc8ioZWgzlhjzidPtU
         ACiN+g8Sa0ci1cGZKVsCrR+0X+ixVJvx2lCNLHZELP/Mi4hrbS+j1Z97gOdOsPExymeU
         2KEfDfelRXsaV+vlSGyyeh59SW/lDt49AYCL/a4ecYYT3Lm1403ezuFrykr1XW+I342G
         60CwpEoGrUHR0yMKfrlyTTG9w4dNfw0CkxKpMs+aavVIwLpKTUv6kjMp37HpWXWe+BnU
         5wJMZTxM4QVgagLrENbyn2Bw6KQ423Xhh45mpDKHKivLBUlo4Xidq1Ja0emkgKZ4pZbn
         p+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791498193; x=1792102993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VSHSXGo0t4Q/EUEgBQMVKzpQrM64wVJhdXCVhdhUM/Q=;
        b=M2Ts2roC4xjzBUH6Zw+DQE84TZteLlHD+qe5UNOE9/NiMnlkTMuCEU/vUnr6ks+8Nz
         d5UxNSjjRsVKPmnNpnefDNS5oO3T7KSTUdBuzoQskC/DPeiyLb0Vm/0LmnS1JDtQywab
         5n6NaWF7zp9QaVKzM5ol8fyXZPCxBkjxv4SHmjho5tdHwP11bLLuPi8GjidKc1EA+wJo
         cfDOQ9UZdlnZRE5wtjov1bRYJx3LtrYYZnZwk4yqo+TAzWJXIMBhb2O/jnmi5TJ15j/p
         HG8HVwdrTK4ElFO9HyT0PHN7dNursHcR3//+7eIh7iMcPh1NGyTaURjXkJ1TVQzJ9VZ1
         eIGg==
X-Forwarded-Encrypted: i=1; AKwUvBwnljgEOs8rYgOprbBVz8lqfTD6lwXKN4F0PHL3Y3x/BSL5yE1qGV3x6Yw+ZcUBdFq3TXd9gsId86/2jd9o2A==@lists.linux.dev
X-Gm-Message-State: AFuF++nxzh9pR6CyE+DTpUo05Skp0WTcl+RgAaDTAIFgMHNMoy0/QpfU
	0qSnKao6YpRCb1AnUYPU8iab9AD2bQEQmxH5cOw3xsOnK5791S3FaF5+8LOh3LTiLqg3tCpnWVL
	fM7VY2f4z0F4MEACi0vIR41S3Q2OyCOxrO19Cia+y7w==
X-Gm-Gg: AYBFou1ebqXPGM4ndyzUfS+9Ec7Uagg0EhR3efE2o7yckUpa43sfuuCQcHO9mz6Mj6l
	QyHwAhxabM5sozIUeU41y6D1cS4Jv1gcCwInsGN/3l7+w3/a8CH3jxFqyNBhk5RuLDdfDOMjVrw
	HNX40/70W5gXHgJUdu6Rn1VhJ/qPzJttWQwnqazcyuZhKUwlO6mSNTIobtWkYRpvsk7jVURS3pW
	vwFpcIvQw5knOmZJ0sk0nguf8Xxu+fJj0/QP6jEvh/VMtNUKyhf4VqT8oYygQqYPOIbrToRWfEU
	hWsp6YUG1vv2LtN0HtJdYlmaoFtXC51xOxHIkkw/ZbQ0QdPvHI4XHVs=
X-Received: by 2002:a05:7301:1522:b0:351:6b56:6627 with SMTP id
 5a478bee46e88-3537e0f5b7bmr297127eec.40.1791498192795; Thu, 08 Oct 2026
 15:23:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261008220256.1844072-1-jkain@nuro.ai> <179149781385.2527009.3611488194198236417@kernel.org>
In-Reply-To: <179149781385.2527009.3611488194198236417@kernel.org>
From: Joseph Kain <jkain@nuro.ai>
Date: Thu, 8 Oct 2026 15:23:00 -0700
X-Gm-Features: AclHuK_Ra0QaGiegHrPWZPoYKlS9D9eX_jvak8xFNq9tYhv-FeTeUsvK1RI3pXs
Message-ID: <CA+Y90PgfrfJa2057FwbW5=9LRBOqh0EwgWW9kPqynWoFhp7-Fg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: do not let defer_count outlive an empty defer_list
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, edumazet@kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de, 
	clrkwllms@kernel.org, rostedt@goodmis.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 3:16=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

  Manual code inspection, LLM-assisted, during a backport -- not hit in
  production.  I hit the heavy contention on sd->defer_lock in
production and had Claude Opus

  The context: an arm64 PREEMPT_RT system hit the sd->defer_lock convoy tha=
t
  844c9db7f7f5 removes, where a descheduled lock holder queued every other
  consumer of that NIC's skbs behind it. While backporting that conversion
  to 6.1 I read through the new code and found the absorbing state this
  patch fixes.


>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

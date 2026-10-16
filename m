Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB30457E6E
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141230; cv=pass; b=V1AFpD8ykADiO9fQ2jT11OW9Nh6NQe9YVt+JLmT8I2MNYcPaVRaj47tj6/Fk86fz6wEFjUsimoWIbcEHPOQmyagnT1LJ7d/ZnYlcQlphxIi63IgJ3PO6vPvqZNETxOU5k6a3y92no6E/zPnTTLVYlMfCbP0PH/z+MOnjrWJLt8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141230; c=relaxed/simple;
	bh=OVzfRZdbw7s/lzMKC8M5X9MPCV4GrzsQdddsKbt+Ujo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxHS4FlUpR22+niVzUwXmgTkZ350LXjJNGwUf6n87IztddfyQ4P0E8gMV/Q5FVfRVgm/rMlW8dnYCYHKTjg/SIjss2U6FOKA1cvXHANSQAwuQ8GU9lE2AlV8Wcp5cj46O5yeRKpbTQorjl0CwPI10/SeFxzj1vAWeg/xddPCCe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=D5BvNpUB; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="D5BvNpUB"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ab868eb9cfso1168465a91.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 02:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792141228; cv=none;
        d=google.com; s=arc-20260327;
        b=EooCPJDgeekPn35ZPcVQ1jigEmoDvp7W5MA3ReuVjhygRloecXHHkzbSh22aL6eJX0
         R50YEqNpjy3WFKhffbHXwMHE0HfGAZYWfzei3mGVi5Q7rKz3RlUCeFqwn7gHdNiauJgJ
         9Uz5Kb0xWHniJ/MnijQ/I93DmoO1KwxwhAUU+10fh5QNjOvGnJgLSOaYXSF/ePeVvA1C
         wg90KaPbCqU2HMd8mL6mQYcV8NZQEGvdBnaZeDvfZ6NywOg3Ai0r0P+fkPR91YGXVKi/
         ezhg8hfPCoXTnvCSByiDSP3tl4bYenUU3kmyzhuMflXtzmttMPxB2fb/QCaW6Sxtl6no
         hd7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K5vZaRJtEgpb/nYXCR3GtSi2IujdlKts4184PdxaRd0=;
        fh=/xcvJu/B2pCzA2DAAsWt63CAPGtoF39wpS0j78X5noA=;
        b=D35gpqmxNI4gzgu8w7XTKoikx8ndNSEvMHc42F/fNlrSmulLycVNYuoqWMs3CfU7iJ
         K8GppTwI8hjgLW2pJ0cF4Q0uhDqRjybKcafidjnSy3zBmZgxGhSuvxRz6VKKj97RrIIB
         48uWmtWE579bPrTwegk7Z9g+SyO92JsUZ6gkupvd5RpmdoV4iMlbma3UMvc8Dwn+k2qQ
         I3uSRq+t+BBNKzPMeTV2cgSetz2+eqTyfGQn/Tn5RyuJZJMkWmn3353zQIv5+NijjJ7J
         Hr5NMaDI7ZUoCNrXvczmEOA+yev3MkX1AzD6Autcd1LeuWskgjT6EhYraNllABLd2Bgm
         6UIA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792141228; x=1792746028; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K5vZaRJtEgpb/nYXCR3GtSi2IujdlKts4184PdxaRd0=;
        b=D5BvNpUBLQ1/VEW0/GCE726SGR9ITgGajQruGZOK9HCnJOClYiN//lbK33BuqO1Hen
         MR5TO0EP5gyBp/FZBlOZIpx9i/a2MQ0tIyrAVfw0B5HjuiA1wZAy3AziVFz3Z7woGb21
         wKHUrd4ez4GLqU/99J6aSjEE7JPnTnkndlhYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141228; x=1792746028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K5vZaRJtEgpb/nYXCR3GtSi2IujdlKts4184PdxaRd0=;
        b=tiLAn4Xz1OUgGF7IsshnDt74d4lC1Oqhn/Wk3HSV7NgOfTxdPIH2u+5MdxIoSr8WqW
         qoHuQfFnju2AOvElrdbfJqGl/nLQsm+3hQR0EncWJn8CxymEqPnuWLj6Peto5AQD8dTZ
         VnSmVjnts2Ag07N18W5nqKujf4txHO0fe9dG19hhdIcXrxX0c3kwv40GobYRTNBXiMmu
         fc0GCWV4vMZ5l888mqWNw1LIKrg8/fnBmLh6EqijjMYqWmVNKbv+O7PIb94ptF/Ib/pm
         YbnK8P6AhUPVURpxDd5VI2DLyRIk+vR0DL1pmEeVNwJKXniWR+tojN+EIEgxubb7R53V
         Vkeg==
X-Forwarded-Encrypted: i=1; AKwUvBx+wcrPSCbik/pBG7lyArWuH1Fa4h0MwQom4bcEALc+p0NTjVEYoxUkNVAddr2Cut455vGj/6TpSeijL7zh9g==@lists.linux.dev
X-Gm-Message-State: AFq9FYKq5XQDssNq69UVmtS2MhUn7EUSiS3eVjs28PYQySC5MAmV4NFT
	yzsLou4U3m4myl9DnTZRnO4XnfdWdR+x6vBIwApz4u7ERPV8RAINTmN+zYH09ChsOYEOAeBbPHb
	qA/ClhlL8UVCphRu7Lxh54uOpC/lzUwDcGKF7Mugr
X-Gm-Gg: AYBFou2cSU9djYTOt6YNVw/IwZt2eR5EKsYu7sM/j+r8aauH2AA/UHAhkKPh+jkCkoh
	WoxRp2fXIAI+cnsdhcYXZoO6V1QmflGXeJr7fB9zkNk+d7UNKIO25CLOZtpEELlPvBy4vTtzHwQ
	36WeJDlu5QSoSqTCvFvqPue6Ftie6/weV9eO+XD2BXe6zZZagxbKBcHRtbJTFyXcBPXazef1+p5
	bN0EjC0e4KXyf/PGBHh4vySxFC1ffVfh/L6hOJL6ErSURC22JY77YWh8vkUKF433QNVG2CjZH2F
	/RdkGIAIfmcbgYUhhD2kOZjW7kTugmBAksSqn2JFYb51Td9aycn3E1P5JwJ46DUY3DT/YD8qckS
	NVrY7sz+gs0KrbECKXH+N8I2SW6gWWVGY1NlLKgBccs9v
X-Received: by 2002:a17:90b:4ac9:b0:3ac:c005:cf07 with SMTP id
 98e67ed59e1d1-3acc005d046mr2346529a91.42.1792141227770; Fri, 16 Oct 2026
 02:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <QDISC-Y0BY.v1.r0.20261015184107@mojatatu.com> <179214079109.408196.5152796723435821487@kernel.org>
In-Reply-To: <179214079109.408196.5152796723435821487@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 16 Oct 2026 05:00:16 -0400
X-Gm-Features: AclHuK9CcjmyT6uSXvsASMcDVgH1hUyqtUYOnWylPW-Z9sshIHj2VYWrJCmAPrw
Message-ID: <CAM0EoMnb78SoNwrqgH5308B_+Mh1sBtm+wJ=SFXtMHS-L2zfXg@mail.gmail.com>
Subject: Re: [PATCH net 0/2] net/sched: sch_teql: fix transmit-path regressions
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Victor Nogueira <victor@mojatatu.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Patrick McHardy <kaber@trash.net>, owen kwan <owen@verialabs.com>, linux-rt-devel@lists.linux.dev, 
	stable@vger.kernel.org, sashiko-bot@kernel.org, 
	zdi-disclosures@trendmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 4:53=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>

Patch 1 is a followup that addresses an issue discovered by sashiko
and proven by our system.
Patch 2 was sent to the security list - likely from a drive-by AI
submission (i.e found and produced by an LLM). I am not getting
responses from the OP but have veried the legitimacy of the bug and we
have reproduced the issue; and it looks serious enough to push
upstream.

cheers,
jamal

> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

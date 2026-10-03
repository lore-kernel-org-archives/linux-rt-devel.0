Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE6C3845D8
	for <linux-rt-devel@lists.linux.dev>; Sat,  3 Oct 2026 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791049199; cv=pass; b=Opw2GXjzRPO5Sppq1r1d0RjjevlKD1LZej3HUW1CDEG3OBC6AOItrIHJZjEQLknBJAnXAfp24V9K2YwH+DDQs63PFW0FclD2UIBinxwPMzQ4Ey17XMZA1TkEzgf/AwTtrZ9NtaRQYxgxjUfTV43QDTnIOdCBo84KvqFOeTjcEQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791049199; c=relaxed/simple;
	bh=TIM/FkEd2LW4QIqIhswYwuTQuctqLS5573zsCgz2EZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7WvcSclcQUvXHN/atujxVkT2TCvrgW27+9q75R9p2VK/CTBvB07pA3hE4fyd44ncnzYVRUoexgEA6jSmgC+JRn1pqtpHIM7wAQMah3Q5TEqIrhp754HfhYMyLx1r4+MG9mdZJqLdE2800Ip3zQbrTYTQCeUu5XX1LZxNcIWpiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=io4bmJym; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="io4bmJym"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-34bb8b31647so1028472eec.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 03 Oct 2026 10:39:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791049197; cv=none;
        d=google.com; s=arc-20260327;
        b=LJP6KuhW6HkbV0h06n/IuS2BzrzWFknU9n829KfE7nCZ6eSUmmCdTNWcGSy+5jUS32
         bVI0lH/PiD6NMt51DY2Dl9NYKRl1IGOCIWCX3dxXMKgAKbp+Khbpp5LGjAwXn/wUHw1W
         3MdFccYE7OQr0HjakKgFY2WYRaIan/R3bOZ9WnD+83gBp8x3aQEyoDsAR4qTbN4j+Slw
         frxEQaYE0JSSRurTaF090nbHQo70dn/Sdlvo7sXRcibR6x8QGHwLAa9JwJ1mKREfSWWy
         7F0atBET7sr5wN7EkVd9tzuiUUUfi0uBM/fVsEC9Fe4hPj0Km7q0q21OnkL0T7tFExGk
         bilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lFnqgsSeoGHR1ZREgHRbdn6RIhZcMzx0GUNeyE+fwl4=;
        fh=hpLbi9N7Pje+FMHFz9Qy5VgHNwlipKqm4TcHKK3+Wgg=;
        b=KbPaVgGRmq1tlM1l0Q0MKC03BcNXSFfGlpjsp4TiZDlfelojN3YJyTy57U2x699NzZ
         jQ68G+qfLzUQIOHGa17prxP3XAPPUoLgAj3gfi/2pmDASPs6zCGWq3D2e9eXkcxkD1Ik
         nb0pRZHLJ1819HYBrnm/3903sCmmC/bC3N4DCQDSvpXQT1t7kpEkgkZi2WOwgHYH2UXI
         tGGZ1oalYtRsosQmu2drtINZF6uUzPPvKIlSs3sUFmBQNSoK9xcrXWP/3OI63iFhuI3Y
         B+7XMoV/UUpKh2ueTSm4C9C9ATikn9Iyi6JfYdIAEcWpqCSNhgXZHLBWaAA+rXzIMTOD
         yDLg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791049197; x=1791653997; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lFnqgsSeoGHR1ZREgHRbdn6RIhZcMzx0GUNeyE+fwl4=;
        b=io4bmJymfN3i8YDEMto7TLiXY3Iva4N7MoALVk2Yd3QVDrBX9VIEpLQkR/UXFBHEFX
         gXRRmQBdzA43AJeFs1aFOA4FYP7SwrKN9JF1MZgwD6ZRkXQS9Q0cNL7epWmiO6ahsTn6
         1GSoXZZAJidqbaFrtYNVBVLULutD3Me39lNvat834uKzn9FzpCKFNtzTMuhjWKoNZX84
         xDNTWqAm3ITbB0msgW7DXfTUQq9vVVtzwqJO1wlAcQ3oNqXRK8Pa9gmXOK/n4GOWD2I/
         qoWnR6zbLIlAx9/jcp2Q6qIF8jp5VO+2G1RgXvM+wIXuEXsYKMO365ZWzJehcF2WzekL
         xumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791049197; x=1791653997;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lFnqgsSeoGHR1ZREgHRbdn6RIhZcMzx0GUNeyE+fwl4=;
        b=R3w4KdjRilPs6V9IaDBhMa4DC+zeEtkFv69yoAv54sadc39poY26L9D6X2VsUU8obP
         sF+mMWOFoKBPrU9+IJg3pRmFIJCb0pPE94kNMfKC7BEw2blAsSYIoQ52YXV8jLhn36+n
         7Fy3zbkRGvJ4at4TxTOcjQAY7nlA9WNO7+uOnqHYueZk7aX9IBuKw3zBMOP6t9slbMvn
         NfFTJdLjFOnPTetD84blT5RCU5hog07GV1F4h1d7iH6NvFPmqsBG2F8uXGgufshtwCrH
         ai9/2DNsE1NFf/7qaW8iQrbJGJMqBa4nErK2KcManOsoXpJg7wEDw3UOrSpvtIRsMGQ6
         tYtA==
X-Forwarded-Encrypted: i=1; AKwUvBwGXvSE58eY8bjiWJgWISF2fvPyeeiorlhUv6Id6h2rxOBswa75HuFw5SeRpdivZgk+DNJnLLQHYOpaf42a0Q==@lists.linux.dev
X-Gm-Message-State: AFuF++lv65TVcr5NiY5YmoUHbW754J71w4PncvzX3xeOb/uBMOW2Y4pL
	rYJRQjXRJ2IfpmjSnijlipca5Xu+yJ9GZlnB0lfeAIuQxJYWufLSFJRsb6Gjfrmr0jBMsf1c3PI
	nM3Eqbey0th61PVqZwiG2AOmoklnIAltcsTnh+Zs/
X-Gm-Gg: AYBFou2ReEkaIqvI3glSfiBmLP5nLSpiO30NSrjRCTGGKw45MU+zIYSIlEVoy7bEZeN
	z3uWJbx9cxmMDr0jGWheuFq7TvkOVfxbfFN0XiKMIqhKZYCC3w5kaSCsSesbP/8+Yw+zvmbR5xt
	eUJ/u9dGpmlyQGiDm8lxVzwnxBqcUNw7uTqlT3yRuoqu2uok0h+ciOBDQpPNwobyFX4XPQft9vN
	NHwR0ZxQHMWpdUEIbUXDvaDUB8m6q2OSyfcR7uoN40WoIavEe1ZKrGbmCZOnnw5eB0idai0EmzC
	IJEhNa8sopEHlKrnDUW0RQH53UQ4hFG3NXlplx839zbyoshf+Wd5r3C+rOqNnxLMshch3wU2qWk
	rqJx+tUOLXfi4DZnT4a7QgMTBb/FHn02uwBFTZmq51LdzIXapfg49xQNjuqHcIMl7ZqUa4MEGXv
	5bcV5GQnuV7lmZt1Ugf0yitFo5
X-Received: by 2002:a05:7022:1509:b0:143:3c9f:109e with SMTP id
 a92af1059eb24-151c425fe14mr4276645c88.41.1791049196034; Sat, 03 Oct 2026
 10:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260930162457.4ajVJ-Qa@linutronix.de> <20261002125357.200a5aeb@kernel.org>
 <20261002215412.lUoSB2XU@linutronix.de>
In-Reply-To: <20261002215412.lUoSB2XU@linutronix.de>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 3 Oct 2026 10:39:44 -0700
X-Gm-Features: AclHuK97qkSua9kDfu1Qq2nIBDYZXmqwXzgzFlTaBvNFH-pAmZ2WGZ7J_B8ry-c
Message-ID: <CAAVpQUCuV_MNMzWCUBOEGN3Tsvykxq8Ba5cukzR9GoOQjh5asA@mail.gmail.com>
Subject: Re: [PATCH net-next v5] af_unix: Do not wait for garbage collector in sendmsg()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Nam Cao <namcao@linutronix.de>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 2, 2026 at 2:54=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-10-02 12:53:57 [-0700], Jakub Kicinski wrote:
> > On Wed, 30 Sep 2026 18:24:57 +0200 Sebastian Andrzej Siewior wrote:
> > > From: Nam Cao <namcao@linutronix.de>
> >
> > This looks effectively identical to v4. I'll put it into 'Needs ACK'.
> > If Kuniyuki is unconvinced please do not repost this again.
>
> basically the same, yes. I did try to explain why that flush does not
> improve things. Also I added my notes (as a reply to the patch) where
> the bad boy consumes a lot of memory and the GC+flush do not help. This
> looks like current limits are too high. I am also not sure if the memory
> account for sockets in this case works as expected.

It works, but only with memcg; AF_UNIX sets sk_allocation to
GFP_KERNEL_ACCOUNT and other objects are also allocated
with it (or SLAB_ACCOUNT).

The default RLIMIT_NOFILE hard limit is 4096 and fs.file-max is
scaled to only 10% of RAM, but systemd decided to blindly bump
RLIMIT_NOFILE to 512K regardless of host memory size and disable
fs.file-max (see systemd's 52d620757817, a8b627aaed40, and
09dad04c49ca), relying on memcg.

Also, I'm still not convinced.  As mentioned before, flush_work() is
neither for OOM nor for the case without dead cycles (any process can
keep RLIMIT_NOFILE FDs inflight without cyclic references anyway).

---
pw-bot: rejected

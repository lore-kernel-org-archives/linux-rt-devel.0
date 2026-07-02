Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF1231326C
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Jul 2026 03:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782962890; cv=pass; b=BvHmQ6qkCRDvylP5be69g5H77IsgXYVZjOBfCRrzfbkBVCoyXeTU+hBsQirWlZILkBz6ZUnnFNu5i4qe3sg4M10cIdJprYb+CqSGNEFJItuX9m+K8lgkqLModjoOt2Z8J1JImWGsQptexc+w2z4ctVJKiA04liPt2SoxUmTfmpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782962890; c=relaxed/simple;
	bh=6twbAqzHSDVib4XGA6tF0E43wBC2SfvJwJvAtu/WDJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oDxBQIz0JNIAOhnj0vyrkoXUvhrBX11yk9oWAUJsCkHxuHqaWgJDOhG7dJluaUTeoZBIw91GuyGsssCUd7Pfvud3yG6slSUbUDZ0wihO1rZRnAf3JPjNp71d+IdI7saZvasQLQbXx2odoKQX1cz8okcPP32jJyE9cLBfqwkA2rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BSX9IXPS; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BSX9IXPS"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c9b1edf2bdso11272525ad.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 01 Jul 2026 20:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782962887; cv=none;
        d=google.com; s=arc-20260327;
        b=PkzALzPszNbnHMvL3Fqyu44LeDfQZWmbQYYZzoxvASGNdaqa2o4s/zDpgQqMLrSzzO
         MnUcQ7JPsG+l17vumFRHAi0YqRcKUVWApsJdZr1xIGBKWk9+1Bh5rfAskF/+xH6WHgBs
         frywjabFLeoI2ajt1m3t76EFZX+Ct16icPDCDymLJAHsxwkO5xA/Ldv5YGiYm5nQw40g
         aSg4QgZZnvGMctvEuUgEkthh2VqAV0AdL/V2lRI2R+Bp2bDPLb4SmWSHEHyR2R5SR2tp
         3dM7T6sSbYccCTzsMISfaE7H95CVE9u9BAyvP3fvod5GTGTagi5klb+4J/zDQLiIZdm/
         FC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BLmcQCP0CBFMMPDNg/zDhtk9PAcOKILSNB3reqJwEiU=;
        fh=pBaksBteYZLAS0n2HoILCr6wYIRs1ZaaB/+4sYDRVvw=;
        b=UmcMVJkIHWG2J4n2ik7aMoiLchpvVv2W7ubfnvfZ70HziN3avSqhsUTTxEnwtydSwi
         OQzLNDKxwdK/oDzjIyywytpPptOM9UVOIRQ7WHc1b89gCFGD4boew1MHQejnfuqFor1f
         aBSUhIAgcFMNha3XCkpMhrGurZlKDk1pBOHk4O7CACYV6elhELI6zEAuBfStL6sKiMbB
         sY9m2cJBdW/QnowmnGWQaaJo76ScNEmwu5QiaNGTOWZe01xym6raI2Gb9l1sv/RwlifP
         mY/xse2snKCAHdxFka8XCD385TYxG2fZQkd/x7x2Ko9rd4/B9Wo6ynHL+6wmqeAweg9g
         CJVA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782962887; x=1783567687; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLmcQCP0CBFMMPDNg/zDhtk9PAcOKILSNB3reqJwEiU=;
        b=BSX9IXPSmY3uEZGa7dJ476Xr2hHcZHCI1y1PJopWF2vXxUHkwDoX85ms+tQT+X8p5I
         3BzbbquD0xI9UP1rJ+b+kBW6E1tsGW8Kzs5CzK4lzo1RO95QBDr0Pm7CYZAXxJ3er7fl
         /nyb62ttjj6ZcBEL6eB+eqOGmsVJKYaMdG2DiDnbJBr+b0kHPbOsXjqFA1Rd2GH2tNya
         S5fcg+o3hRw9i7J6Nuos+s9d+L2AbKW7I7rMf9W5aqLco63+xBogtSmB/kxmKYv5WHJn
         8PstgDXdnCOtsUn7YPmE5IbS3W7D1DA1ZM+GQ3wjxMRUXGJVcDyLO2wICcTWkqhG+5ij
         nupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782962887; x=1783567687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BLmcQCP0CBFMMPDNg/zDhtk9PAcOKILSNB3reqJwEiU=;
        b=C5z+hMinvFyhq1MRbSisoyTVBIVa0Nn/CL+5pgD+B6R8pZXznBBt2zIf2l3DX0Q88S
         xfblX87UJGiEvGGUaL9mkYVfpgSYIysQGXZAANS01z/iWEUbzoB8RVNWx2rNNkcKxfqy
         xTdzo+Sq6EMhLgWT8onBUpKxx1GVMJFhaQFHJSt/MtzmO9/MCmE6AdrObX+6NqERhhiP
         2N/eWFSTXFhypKTmFdo4UrJXHWw7NiWOHkkxBfkJMyzXK3WKMwMjmk1za3sUEa5QR2fe
         Rnv2p0TNVi4C+U7cNi0pZC3jpJqhMsDKqZBh4O+aJQZol3epEsRgp54vQz+rgWQO955R
         8Zow==
X-Forwarded-Encrypted: i=1; AHgh+RqfJWSEwV4DY+7VopHY3MXcXdspPGx2YwdDJU9KDuxj2Eh7ThiMZWx9c96fG1EVKlKINQJRSkOlfuxLhG5BhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzByU2RIDliPFcNphl4p4UmCmLlPXWbFuEkpa/87WyeMb0TRxhe
	9+par2mHx/tZX34jJwU5IfFvR/e0VDOroYOp4rolP4p3GHb3y14mzX3Nc9/XiU+JRkd8O0Yihr0
	LOoJY7/duj6EYnPwWODiD/1OTF21EoiPGQZaiM4LA
X-Gm-Gg: AfdE7clPvvy7ZLVS5VCAaujZyclXL0EoeNPw7pzfJB9P3VdfLF9JtSf0X/TC6WUpklg
	Z0G30W/fUZFUGbkKukHLdxaUwyk5V/qzykd2TGDgPkus53BESys0KVJJH6hD9TgXhKavgSfI0LF
	1YfuHHGc+9gXIDuzdyMzbYQjZ+eth8STpbnZdB3ONXYyHWT4LG/1mn3nLMXHIdBXwX9ygtArHcm
	zJVvHVRG15KYNO6bzQK9c1MhiggMzJbncjf3D69C987H2mOVaYXkjvG0H44tjQTB7XCfdqiWoEy
	+bzorNdpeH1nn22BaRc45R8O45nYiMHImKmHO4BppueMkfzI0Ftb9t8BsJ2+DYuB1O3TlMMxeOg
	3InP9HUoltPSCPjPr7hIl0Pn9/3Xyoo5MVS95J2aeIQ==
X-Received: by 2002:a17:903:2c0f:b0:2ca:12aa:a395 with SMTP id
 d9443c01a7336-2ca7e6a62bamr52821975ad.17.1782962885989; Wed, 01 Jul 2026
 20:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1782922354.git.namcao@linutronix.de> <e663a83195f3d9f6d7ad4907c37ae3e45c151062.1782922354.git.namcao@linutronix.de>
In-Reply-To: <e663a83195f3d9f6d7ad4907c37ae3e45c151062.1782922354.git.namcao@linutronix.de>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 1 Jul 2026 20:27:54 -0700
X-Gm-Features: AVVi8Cc0CdVhsx__5HGrso2HoD3JAKnt5KjxP05QA2kzwt5BhmMX2QVBhxsy3SY
Message-ID: <CAAVpQUAKESwPnzZAJSsSgR_perYn+S3PbnDAexnWdeGAeGcekw@mail.gmail.com>
Subject: Re: [PATCH 1/2] af_unix: Do not wait for garbage collector in sendmsg()
To: Nam Cao <namcao@linutronix.de>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 9:36=E2=80=AFAM Nam Cao <namcao@linutronix.de> wrote=
:
>
> AF_UNIX sockets' sendmsg() schedules and blocks on the garbage collector =
if
> user has too many inflight unix sockets

AND there is a cyclic reference

>. This causes real-time issues, as
> high priority processes who do need to send lots of unix sockets get
> blocked by the garbage collector which runs as workqueue, causing a
> priority inversion scenario.

So the real problem is the process creating cyclic references.

>
> The reason for blocking on garbage collector goes back to 2008, when
> it was reported that "Local/unprivileged users can cause soft lockups
> and take out system processes by triggering the OOM killer":
> https://bugzilla.redhat.com/show_bug.cgi?id=3D470201
>
> The soft lockup was because a process can keep queueing AF_UNIX sockets t=
o
> another process that is exiting. Back in 2008, the garbage collector was
> run synchronously by the exiting process, therefore keep queueing AF_UNIX
> sockets blocks that process from exiting.
>
> The solution to that issue was forcing sendmsg() to wait for ongoing
> garbage collector.
>
> The OOM killer issue was brought up again in 2010:
> https://lore.kernel.org/lkml/AANLkTi=3DQ967xpX0KLMwX-=3D_4_1AKO5wjHEuJ1Tr=
NjCj9@mail.gmail.com/
>
> To resolve that report, beside blocking on the garbage collector, sendmsg=
()
> also schedules the garbage collector if the number of inflight AF_UNIX
> sockets in the system is too high.
>
> Then in 2015, once again, the OOM killer problem was brought up:
> https://lore.kernel.org/lkml/20151228141435.GA13351@1wt.eu/
>
> That time, the issue was resolved by disallowing a user from having more
> inflight AF_UNIX sockets than their RLIMIT_NOFILE. That was done by commi=
t
> 712f4aad406b ("unix: properly account for FDs passed over unix sockets")
> and commit 415e3d3e90ce ("unix: correctly track in-flight fds in sending
> process user_struct").
>
> Now, sendmsg() does not have to block on the garbage collector anymore,
> because:
>
>   - The OOM killer issue has already been addressed by checking
>     RLIMIT_NOFILE.
>
>   - The soft lockup issue is no longer relevant, because the garbage
>     collector now runs asynchronously since commit d9f21b361333 ("af_unix=
:
>     Try to run GC async.")

I don't think the latter is resolved.  Without blocking insane
users, they can keep pushing sockets to the kernel work,
which could be soft-lockup'd.


>
> Therefore, remove that to prevent priority inversion. Running all the
> reproducers from the mentioned bug reports after this patch, no problem i=
s
> observed.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  net/unix/garbage.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/net/unix/garbage.c b/net/unix/garbage.c
> index 0783555e2526..f180c59b3da9 100644
> --- a/net/unix/garbage.c
> +++ b/net/unix/garbage.c
> @@ -300,8 +300,6 @@ int unix_prepare_fpl(struct scm_fp_list *fpl)
>         if (!fpl->edges)
>                 goto err;
>
> -       unix_schedule_gc(fpl->user);
> -
>         return 0;
>
>  err:
> --
> 2.47.3
>
